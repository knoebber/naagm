defmodule NaagmWeb.GuestLoginLive do
  alias Naagm.Accounts
  use NaagmWeb, :live_view

  def mount(_, _, socket) do
    {:ok, assign(socket, :body_class, "sunset-bg")}
  end

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
          <input type="hidden" name="user[email]" value={Accounts.guest_email()} />
          <input type="hidden" name="user[from]" value={~p"/login"} />
          <.button phx-disable-with="Logging in..." tabindex="0">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="M5 12h14" />
              <path d="M12 5l7 7-7 7" />
            </svg>
          </.button>
        </div>
      </.form>
    </div>
    """
  end
end
