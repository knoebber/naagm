defmodule NaagmWeb.HomeLive do
  use NaagmWeb, :live_view

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <section class="align-center">
      <h1 class="amatic-sc-bold huge">Anna and Nicolas got married on June 21st, 2025!</h1>
      <.link
        class="button big-button"
        target="_blank"
        href="https://kolbywallphotography.pic-time.com/-annanicolas/gallery"
      >
        Professional Photos
      </.link>

      <div class="home-wrapper">
        <div class="portrait-wrapper">
          <.image class="portrait" path="uploads/homepage_portrait.JPG" />
        </div>
      </div>
      <nav class="sub-nav">
        <.link
          :for={
            {label, anchor} <- [
              {"Schedule", "schedule"},
              {"How to get there", "directions"},
              {"Where to stay", "lodging"},
              {"What to do", "activities"},
              {"FAQ", "faq"}
            ]
          }
          navigate={~p"/about##{anchor}"}
        >
          {label}
        </.link>
      </nav>
    </section>
    """
  end
end
