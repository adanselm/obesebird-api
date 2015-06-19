defmodule ObesebirdApi.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :message, :string
      add :category_id, :integer

      timestamps
    end
    create index(:posts, [:category_id])

  end
end
