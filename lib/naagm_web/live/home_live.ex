defmodule NaagmWeb.HomeLive do
  use NaagmWeb, :live_view

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div class="home-wrapper">
      <section class="image-grid">
        <.image :for={_ <- 1..12} path="airplane.jpeg" />
      </section>
      <section class="home">
        <h1><code>get_married("Anna Thompson", "Nicolas Knoebber")</code></h1>
        <article class="save-the-date">
          <h2>June 21st, 2025</h2>
        </article>
      </section>
      <section class="image-grid">
        <.image :for={_ <- 1..12} path="airplane.jpeg" />
      </section>
    </div>
    """
  end
end
