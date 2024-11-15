defmodule Naagm.Repo.Migrations.FoodPreference do
  use Ecto.Migration

  def change do
    alter table(:guests) do
      add :food_preference, :string, default: "", null: false
    end
  end
end
