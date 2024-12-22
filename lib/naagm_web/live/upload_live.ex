defmodule NaagmWeb.UploadLive do
  use NaagmWeb, :live_view

  @impl Phoenix.LiveView
  def handle_info({:info_message, message}, socket) do
    {:noreply, put_flash(socket, :info, message)}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <.live_component module={NaagmWeb.UploadForm} id="upload-form" current_user={@current_user} />
    """
  end
end
