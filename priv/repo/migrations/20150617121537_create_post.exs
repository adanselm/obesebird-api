defmodule ObesebirdApi.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :text, :string
      add :last_submission_date, :datetime
      add :is_queued, :boolean, default: false
      add :category_id, :integer

      timestamps
    end
    create index(:posts, [:category_id])

  end
end
