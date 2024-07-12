defmodule Naagm.Guests.Guest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "guests" do
    field :first_name, :string
    field :last_name, :string
    field :rsvp_status, Ecto.Enum, values: [:INVITED, :MAYBE, :COMING], default: :INVITED
    field :housing_preference, :string

    timestamps()
  end

  def changeset(guest, attrs) do
    guest
    |> cast(attrs, [:first_name, :last_name, :rsvp_status, :housing_preference])
    |> validate_required([:first_name, :last_name, :rsvp_status, :housing_preference])
  end
end
