defmodule NaagmWeb.HomeLive do
  use NaagmWeb, :live_view

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <section>
      <h1>Naagm</h1>
    </section>
    """
  end
end
