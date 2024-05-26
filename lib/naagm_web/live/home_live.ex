defmodule NaagmWeb.HomeLive do
  use NaagmWeb, :live_view

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <section class="home">
      <h1><code>get_married("Anna Thompson", "Nicolas Knoebber")</code></h1>
      <article class="save-the-date">
        <h2>June 21st, 2025</h2>
      </article>
    </section>
    """
  end
end
