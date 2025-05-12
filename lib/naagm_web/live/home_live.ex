defmodule NaagmWeb.HomeLive do
  use NaagmWeb, :live_view

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <section class="align-center">
      <h1 class="amatic-sc-bold huge">Anna and Nicolas are getting married on June 21st, 2025!</h1>
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

      <.link class="button" navigate={~p"/rsvp"}>RSVP</.link>
      <h2>Please RSVP by May 21st!</h2>
    </section>
    """
  end
end
