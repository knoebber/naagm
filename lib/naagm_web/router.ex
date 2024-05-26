defmodule NaagmWeb.Router do
  use NaagmWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {NaagmWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", NaagmWeb do
    pipe_through [:browser]

    live "/", HomeLive
  end
end
