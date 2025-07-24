defmodule MyBlog.Repo.Migrations.UpdatePostContentSize do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      modify :content, :string, size: 50000
    end
  end
end
