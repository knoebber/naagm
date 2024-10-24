defmodule NaagmWeb.HomeLive do
  use NaagmWeb, :live_view

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <section>
      <h1 class="amatic-sc-regular huge">Anna and Nicolas are getting married on June 21st, 2025!</h1>
      <div class="home-wrapper">
        <div class="portrait-wrapper">
          <.image class="portrait" path="uploads/homepage_portrait.JPG" />
        </div>
      </div>
    </section>
    """
  end
end
