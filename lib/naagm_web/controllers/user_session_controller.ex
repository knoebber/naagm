defmodule NaagmWeb.UserSessionController do
  use NaagmWeb, :controller

  alias Naagm.Accounts
  alias NaagmWeb.UserAuth

  def create(conn, %{"user" => %{"email" => email, "password" => password, "from" => from}}) do
    if user = Accounts.get_user_by_email_and_password(email, password) do
      UserAuth.log_in_user(conn, user)
    else
      conn
      |> put_flash(:error, "invalid, please try again")
      |> IO.inspect(label: "here")
      |> redirect(to: from)
    end
  end

  def delete(conn, _params) do
    UserAuth.log_out_user(conn)
  end
end
