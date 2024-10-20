defmodule NaagmWeb.Router do
  use NaagmWeb, :router

  import NaagmWeb.UserAuth

  def on_mount(:put_path, _params, _session, socket) do
    {:cont,
     Phoenix.LiveView.attach_hook(
       socket,
       :put_path,
       :handle_params,
       &put_path/3
     )}
  end

  defp put_path(_params, url, socket) do
    {:cont, Phoenix.Component.assign(socket, :current_path, URI.parse(url).path)}
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {NaagmWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  ## Authentication routes

  scope "/", NaagmWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{NaagmWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/login", GuestLoginLive, :new
      live "/admin/login", UserLoginLive, :new
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", NaagmWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{NaagmWeb.UserAuth, :ensure_authenticated}, {__MODULE__, :put_path}] do
      live "/", HomeLive
      live "/upload", UploadLive
      live "/rsvp", RSVPLive
      live "/rsvp/:uuid", ShowRSVPLive, :show
      live "/rsvp/:uuid/edit", ShowRSVPLive, :edit
      live "/photos", PhotosLive
      live "/about", AboutLive
    end
  end

  scope "/admin", NaagmWeb do
    pipe_through [:browser, :require_admin]

    live_session :require_admin,
      on_mount: [{NaagmWeb.UserAuth, :ensure_authenticated}] do
      live "/guests", AdminGuestLive
    end
  end

  scope "/", NaagmWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
  end
end
