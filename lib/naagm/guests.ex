defmodule Naagm.Guests do
  alias Naagm.Repo
  alias Naagm.Guests.Guest

  def get_guest(guest_id) do
    Repo.get(Guest, guest_id)
  end

  def create_guest(params) do
    Repo.insert(Guest.changeset(%Guest{}, params))
  end

  def update_guest(%Guest{} = guest, params) do
    Repo.update(Guest.changeset(guest, params))
  end

  def delete_guest!(guest_id) do
    Guest
    |> Repo.get!(guest_id)
    |> Repo.delete!()
  end
end
