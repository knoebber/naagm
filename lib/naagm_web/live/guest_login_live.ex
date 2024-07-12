defmodule NaagmWeb.GuestLoginLive do
  use NaagmWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="login-wrapper">
      <.form class="simple-form" method="post" action={~p"/users/log_in"} for={%{}}>
        <div id="password-wrapper" class="guest-password-wrapper" phx-hook="PasswordWrapper">
          <label>Password:</label>
          <input class="js-pw-input" label="Password" name="user[password]" required />
          <input type="hidden" name="user[email]" value="guest@example.com" />
          <input type="hidden" name="user[from]" value={~p"/login"} />
          <.button phx-disable-with="Logging in...">
            👉
          </.button>
        </div>
      </.form>
    </div>
    """
  end
end
