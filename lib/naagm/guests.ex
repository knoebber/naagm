defmodule Naagm.Guests do
  alias Naagm.Repo
  alias Naagm.Guests.Guest

  defp hydrate_guest_json(%Guest{} = guest) do
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
  end

  def get_guest(guest_id) do
    Guest |> Repo.get(guest_id) |> hydrate_guest_json()
  end

  def get_guest_by_uuid(uuid) do
    Guest
    |> Repo.get_by(uuid: uuid)
    |> then(&if &1, do: hydrate_guest_json(&1), else: nil)
  end

  def create_guest(params, is_coming_map) do
    Repo.insert(Guest.changeset(%Guest{uuid: Ecto.UUID.generate()}, params, is_coming_map, true))
  end

  def update_guest(%Guest{} = guest, params, is_coming_map) do
    Repo.update(Guest.changeset(guest, params, is_coming_map, true))
  end

  def delete_guest!(guest_id) do
    Guest
    |> Repo.get!(guest_id)
    |> Repo.delete!()
  end

  def list_guests() do
    Guest
    |> Repo.all()
    |> Enum.map(&hydrate_guest_json/1)
  end

  def all_member_tuples() do
    Enum.reduce(list_guests(), [], fn guest, member_tuples ->
      Enum.map(guest.parsed_party, &{&1.full_name, &1.is_coming}) ++ member_tuples
    end)
  end
end
