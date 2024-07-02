defmodule NaagmWeb.RSVPLive do
  use NaagmWeb, :live_view

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div class="">
      <h1>RSVP</h1>
    </div>
    """
  end
end
