defmodule MyBlog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :tag, :string
      add :title, :string
      add :category, :string
      add :content, :string
      add :created_at, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
