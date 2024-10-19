defmodule Naagm.Guests.Guest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "guests" do
    field :party_json, :string
    field :food_restriction, :string, default: ""
    field :housing_preference, :string, default: ""

    field :raw_party_string, :string, virtual: true, default: ""
    field :parsed_party, :any, virtual: true, default: []

    timestamps()
  end

  defp parse_party_members(changeset, is_coming_map) do
    parsed_party_members =
      changeset
      |> get_field(:raw_party_string)
      |> String.split([",", "\n"], trim: true)
      |> Enum.map(&String.trim/1)
      |> Enum.filter(fn s ->
        String.match?(s, ~r/^[\w[:space:]]+$/u)
      end)

    if length(parsed_party_members) > 0 do
      parsed_party =
        parsed_party_members
        |> Enum.with_index()
        |> Enum.map(fn {member, index} ->
          %{full_name: member, is_coming: Map.get(is_coming_map, index)}
        end)

      case Jason.encode(parsed_party) do
        {:ok, json} ->
          changeset
          |> put_change(:party_json, json)
          |> put_change(:parsed_party, parsed_party)

        {:error, _} ->
          add_error(changeset, :raw_party_string, "invalid party description")
      end
    else
      add_error(changeset, :raw_party_string, "please enter at least one party member")
    end
  end

  defp maybe_set_party_json(%Ecto.Changeset{} = changeset, is_coming_map) do
    if Keyword.has_key?(changeset.errors, :raw_party_string) do
      changeset
    else
      parse_party_members(changeset, is_coming_map)
    end
  end

  def changeset(guest, attrs, is_coming_map) do
    guest
    |> cast(attrs, [:raw_party_string, :food_restriction, :housing_preference])
    |> validate_required([:raw_party_string])
    |> maybe_set_party_json(is_coming_map)
  end
end
