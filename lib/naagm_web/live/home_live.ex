defmodule NaagmWeb.HomeLive do
  use NaagmWeb, :live_view

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div class="home-wrapper">
      <div class="portrait-wrapper">
        <.image class="portrait" path="uploads/homepage_portrait.JPG" />
      </div>
    </div>
    """
  end
end
