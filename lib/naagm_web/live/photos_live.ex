defmodule NaagmWeb.PhotosLive do
  alias Naagm.S3
  use NaagmWeb, :live_view

  defp parse_integer_for_sort(num_string) do
    case Regex.run(~r"[0-9]+", num_string) do
      [match | _] -> String.to_integer(match)
      _ -> -1
    end
  end

  @impl Phoenix.LiveView
  def mount(_, _, socket) do
    {
      :ok,
      assign(
        socket,
        :path_label_tuples,
        Enum.map(S3.gallery_render_tuples(), fn {prefix, label, _} ->
          {"/" <> prefix, label}
        end)
      )
    }
  end

  @impl Phoenix.LiveView
  def handle_params(params, _uri, socket) do
    current_s3_prefix = String.replace_leading(socket.assigns.current_path, "/", "")
    utc_now_ms = DateTime.utc_now() |> DateTime.to_unix(:millisecond)
    seed = Map.get(params, "seed")

    sort =
      case Map.get(params, "sort") do
        "asc" -> :asc
        "desc" -> :desc
        nil -> :asc
      end

    next_sort = if sort == :desc, do: "asc", else: "desc"

    sort_method =
      Enum.find_value(S3.gallery_render_tuples(), fn {prefix, _, sort_method} ->
        if prefix == current_s3_prefix do
          sort_method
        end
      end)

    paths_to_render = S3.list_keys(current_s3_prefix)

    paths_to_render =
      case sort_method do
        :random ->
          :rand.seed(
            :exs1024,
            if seed do
              String.to_integer(seed)
            else
              # when not specified, the seed will change once per hour
              round(utc_now_ms / 1000 / 3600)
            end
          )

          Enum.shuffle(paths_to_render)

        :alpha ->
          Enum.sort(
            paths_to_render,
            fn a, b ->
              num_a = parse_integer_for_sort(a)
              num_b = parse_integer_for_sort(b)

              if sort == :asc do
                num_a <= num_b
              else
                num_b <= num_a
              end
            end
          )
      end

    get_loading_style = fn element, index ->
      {
        element,
        if index <= 4 do
          "eager"
        else
          "lazy"
        end
      }
    end

    {
      :noreply,
      socket
      |> assign(:next_seed, utc_now_ms)
      |> assign(:sort, sort)
      |> assign(:next_sort, next_sort)
      |> assign(:paths_to_render, Enum.with_index(paths_to_render, get_loading_style))
      |> assign(:sort_method, sort_method)
    }
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <section class="photos-wrapper">
      <h1>
        Photos
        <%= if @sort_method == :random do %>
          <.link patch={"?seed=#{@next_seed}"}>🌻</.link>
        <% else %>
          <.link patch={"?sort=#{@next_sort}"}>
            <%= if(@sort == :asc) do %>
              ⬆️
            <% else %>
              ⬇️
            <% end %>
          </.link>
        <% end %>
      </h1>
      <nav class="sub-nav">
        <.link
          :for={{path, label} <- @path_label_tuples}
          class={if(@current_path == path, do: "active", else: "")}
          patch={path}
        >
          {label}
        </.link>
      </nav>
      <div class="image-grid">
        <article :for={{path, loading} <- @paths_to_render} class="image-frame">
          <.image loading={loading} path={path} />
          <.image_link path={path} />
        </article>
      </div>
    </section>
    """
  end
end
