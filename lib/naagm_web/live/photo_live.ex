defmodule NaagmWeb.PhotoLive do
  alias Naagm.S3
  use NaagmWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_, _, socket) do
    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def handle_params(_params, _uri, socket) do
    {
      :noreply,
      socket
      |> assign(:path, socket.assigns.current_path)
    }
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <section class="single-image">
      <.image path={@path} />
    </section>
    """
  end
end
