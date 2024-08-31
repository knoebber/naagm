defmodule NaagmWeb.GuestLoginLive do
  use NaagmWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="login-wrapper">
      <.form class="simple-form" method="post" action={~p"/users/log_in"} for={%{}}>
        <div id="password-wrapper" class="guest-password-wrapper" phx-hook="PasswordWrapper">
          <label for="pw-input">Password:</label>
          <input
            id="pw-input"
            class="js-pw-input"
            label="Password"
            name="user[password]"
            required
            tabindex="1"
          />
          <input type="hidden" name="user[email]" value="guest@example.com" />
          <input type="hidden" name="user[from]" value={~p"/login"} />
          <.button phx-disable-with="Logging in..." tabindex="0">
            👉
          </.button>
        </div>
      </.form>
    </div>
    """
  end
end
