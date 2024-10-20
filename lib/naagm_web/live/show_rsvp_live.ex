defmodule NaagmWeb.ShowRSVPLive do
  alias Naagm.Guests
  use NaagmWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def handle_params(%{"uuid" => uuid}, _, socket) do
    {:noreply, socket |> assign(:guest, Guests.get_guest_by_uuid(uuid))}
  end

  @impl Phoenix.LiveView
  def handle_event("update", %{"guest" => _guest_params}, socket) do
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("validate", %{"guest" => _guest_params}, socket) do
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div class="content">
      <h1>Thank you for RSVPing!</h1>

      <section :if={@guest}>
        <h2>Details</h2>
      </section>
    </div>
    """
  end
end
