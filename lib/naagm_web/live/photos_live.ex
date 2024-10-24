defmodule NaagmWeb.PhotosLive do
  alias Naagm.S3
  use NaagmWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_, _, socket) do
    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def handle_params(params, _uri, socket) do
    utc_now_ms = DateTime.utc_now() |> DateTime.to_unix(:millisecond)
    seed = Map.get(params, "seed")

    :rand.seed(
      :exs1024,
      if seed do
        String.to_integer(seed)
      else
        # when not specified, the seed will change once per hour
        round(utc_now_ms / 1000 / 3600)
      end
    )

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

    paths_to_render =
      S3.list_gallery_keys()
      |> Enum.shuffle()
      |> Enum.with_index(get_loading_style)

    {
      :noreply,
      socket
      |> assign(:next_seed, utc_now_ms)
      |> assign(:paths_to_render, paths_to_render)
    }
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <section class="photos-wrapper">
      <h1>Photos <.link patch={"?seed=#{@next_seed}"}>🌻</.link></h1>
      <nav>
        <.link patch={~p"/"}>Life</.link>
        <.link patch={~p"/"}>Kolby Wall Photography</.link>
        <.link patch={~p"/"}>Rancho Navarro Photos</.link>
        <.link patch={~p"/"}>Guest Uploads</.link>
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
