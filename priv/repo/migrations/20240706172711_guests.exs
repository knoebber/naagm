defmodule Naagm.Repo.Migrations.Guests do
  use Ecto.Migration

  def change do
    create table(:guests) do
      add :party_json, :string, null: false, collate: :nocase
      add :food_restriction, :string, null: false
      add :housing_preference, :string, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
