defmodule Naagm.Repo.Migrations.GuestFeatures do
  use Ecto.Migration

  def change do
    alter table(:guests) do
      add :notes, :string, default: "", null: false
      add :uuid, :string, default: "", null: false
    end
  end
end
