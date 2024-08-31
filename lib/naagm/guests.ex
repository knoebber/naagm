defmodule Naagm.Guests do
  alias Naagm.Repo
  alias Naagm.Guests.Guest

  def get_guest(guest_id) do
    Repo.get(Guest, guest_id)
  end

  def create_guest(params, is_coming_map) do
    Repo.insert(Guest.changeset(%Guest{}, params, is_coming_map))
  end

  def delete_guest!(guest_id) do
    Guest
    |> Repo.get!(guest_id)
    |> Repo.delete!()
  end

  def list_guests() do
    Guest
    |> Repo.all()
    |> Enum.map(fn guest ->
      Map.put(
        guest,
        :parsed_party,
        Jason.decode!(guest.party_json)
        |> Enum.map(fn map ->
          Map.new(map, fn {key, value} ->
            {String.to_atom(key), value}
          end)
        end)
      )
    end)
  end
end
