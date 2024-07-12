defmodule Naagm.Repo.Migrations.Guests do
  use Ecto.Migration

  def change do
    create table(:guests) do
      add :first_name, :string, null: false, collate: :nocase
      add :last_name, :string, null: false, collate: :nocase
      add :rsvp_status, :string, null: false
      add :housing_preference, :string, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
