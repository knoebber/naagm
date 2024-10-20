defmodule NaagmWeb.RSVPLive do
  alias Naagm.Guests.Guest
  use NaagmWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div class="content">
      <.live_component
        module={NaagmWeb.RSVPForm}
        id="rsvp-create-form"
        action={:create}
        guest={%Guest{}}
      />
    </div>
    """
  end
end
