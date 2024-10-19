defmodule NaagmWeb.PhotosLive do
  alias Naagm.S3
  use NaagmWeb, :live_view

  defp shuffle_list_each_hour(list, seed) when is_integer(seed) do
    :rand.seed(:exs1024, seed)
    Enum.shuffle(list)
  end

  @impl Phoenix.LiveView
  def mount(_, _, socket) do
    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def handle_params(params, _uri, socket) do
    utc_now_ms = DateTime.utc_now() |> DateTime.to_unix(:millisecond)
    seed = Map.get(params, "seed")

    seed =
      if seed do
        String.to_integer(seed)
      else
        # when not specified, the seed will change once per hour
        utc_hours = round(utc_now_ms / 1000 / 3600)
      end

    paths_to_render = S3.list_gallery_keys()

    {
      :noreply,
      socket
      |> assign(:next_seed, utc_now_ms)
      |> assign(:paths_to_render, shuffle_list_each_hour(paths_to_render, seed))
    }
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <section>
      <h1>Photos <.link patch={"?seed=#{@next_seed}"}>🌱</.link></h1>
      <div class="image-grid">
        <article :for={path <- @paths_to_render} class="image-frame">
          <.image path={path} />
          <code><%= S3.make_label(path) %></code>
        </article>
      </div>
    </section>
    """
  end
end
