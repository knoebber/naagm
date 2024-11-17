defmodule Naagm.Guests.Guest do
  use Ecto.Schema
  import Ecto.Changeset
  alias Naagm.Guests

  schema "guests" do
    field :uuid, :string
    field :party_json, :string
    field :food_restriction, :string, default: ""
    field :housing_preference, :string, default: ""
    field :notes, :string, default: ""

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

  defp maybe_validate_members(c, false), do: c

  defp maybe_validate_members(%Ecto.Changeset{} = changeset, true) do
    member_tuples = Guests.all_member_tuples()

    parsed_party = Map.get(changeset.changes, :parsed_party, [])

    errors =
      if Enum.any?(parsed_party, &is_nil(&1.is_coming)) do
        ["Please select yes or no for each member"]
      else
        []
      end

    duplicate_member =
      Enum.find(
        parsed_party,
        fn %{full_name: full_name} ->
          duplicate_member_tuple =
            Enum.find(member_tuples, fn {existing_name, _} -> existing_name == full_name end)

          if duplicate_member_tuple &&
               Enum.all?(changeset.data.parsed_party, fn member ->
                 member.full_name != elem(duplicate_member_tuple, 0)
               end) do
            duplicate_member_tuple
          end
        end
      )

    errors =
      if duplicate_member do
        ["\"#{duplicate_member.full_name}\" has already RSVPed" | errors]
      else
        errors
      end

    Enum.reduce(errors, changeset, fn error, c ->
      add_error(c, :raw_party_string, error)
    end)
  end

  def changeset(guest, attrs, is_coming_map, should_validate_members \\ false) do
    guest
    |> cast(attrs, [
      :food_restriction,
      :housing_preference,
      :notes,
      :raw_party_string
    ])
    |> validate_required([:raw_party_string])
    |> maybe_set_party_json(is_coming_map)
    |> maybe_validate_members(should_validate_members)
  end
end
