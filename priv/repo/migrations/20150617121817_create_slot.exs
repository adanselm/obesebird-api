defmodule ObesebirdApi.Repo.Migrations.CreateSlot do
  use Ecto.Migration

  def change do
    create table(:slots) do
      add :day, :integer
      add :hour, :integer
      add :min, :integer
      add :category_id, :integer

      timestamps
    end
    create index(:slots, [:category_id])

  end
end
