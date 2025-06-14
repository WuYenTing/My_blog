defmodule MyBlog.Repo.Migrations.RemoveCreatedAtInPost do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      remove :created_at, :string
    end
  end
end
