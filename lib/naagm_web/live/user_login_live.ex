defmodule NaagmWeb.UserLoginLive do
  alias Naagm.Accounts
  use NaagmWeb, :live_view

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.simple_form for={@form} id="login_form" action={~p"/users/log_in"} phx-update="ignore">
        <.input field={@form[:email]} type="hidden" value={Accounts.admin_email()} />
        <.input field={@form[:password]} type="text" label="Password" required />
        <.input field={@form[:from]} value={~p"/admin/login"} type="hidden" required />
        <:actions>
          <.button phx-disable-with="Logging in...">
            Log in <span aria-hidden="true">→</span>
          </.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end
end
