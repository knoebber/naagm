defmodule Naagm.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Naagm.Repo

  alias Naagm.Accounts.{User, UserToken}

  @guest_email "guest@example.com"
  @admin_email "admin@example.com"

  def guest_email, do: @guest_email
  def admin_email, do: @admin_email
  def guest?(%User{email: email}), do: email == @guest_email
  def admin?(nil), do: false
  def admin?(%User{email: email}), do: email == @admin_email

  ## Database getters

  @doc """
  Gets a user by email.

  ## Examples

      iex> get_user_by_email("foo@example.com")
      %User{}

      iex> get_user_by_email("unknown@example.com")
      nil

  """
  def get_user_by_email(email) when is_binary(email) do
    Repo.get_by(User, email: email)
  end

  @doc """
  Gets a user by email and password.

  ## Examples

      iex> get_user_by_email_and_password("foo@example.com", "correct_password")
      %User{}

      iex> get_user_by_email_and_password("foo@example.com", "invalid_password")
      nil

  """
  def get_user_by_email_and_password(email, password)
      when is_binary(email) and is_binary(password) do
    user = Repo.get_by(User, email: email)
    if User.valid_password?(user, password), do: user
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  def register_guest_account(password) do
    %User{}
    |> User.registration_changeset(%{"email" => @guest_email, "password" => password})
    |> Repo.insert()
  end

  def register_admin_account(password) do
    %User{}
    |> User.registration_changeset(%{"email" => @admin_email, "password" => password})
    |> Repo.insert()
  end

  def delete_admin_account(), do: get_user_by_email(@admin_email) |> Repo.delete()
  def delete_guest_account(), do: get_user_by_email(@guest_email) |> Repo.delete()

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user_registration(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user_registration(%User{} = user, attrs \\ %{}) do
    User.registration_changeset(user, attrs, hash_password: false, validate_email: false)
  end

  ## Session

  @doc """
  Generates a session token.
  """
  def generate_user_session_token(user) do
    {token, user_token} = UserToken.build_session_token(user)
    Repo.insert!(user_token)
    token
  end

  @doc """
  Gets the user with the given signed token.
  """
  def get_user_by_session_token(token) do
    {:ok, query} = UserToken.verify_session_token_query(token)
    Repo.one(query)
  end

  @doc """
  Deletes the signed token with the given context.
  """
  def delete_user_session_token(token) do
    Repo.delete_all(UserToken.by_token_and_context_query(token, "session"))
    :ok
  end

  def list_users do
    Repo.all(User)
  end
end
