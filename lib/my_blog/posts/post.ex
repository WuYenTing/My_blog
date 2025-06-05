defmodule MyBlog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :tag, :string
    field :description, :string
    field :title, :string
    field :category, :string
    field :content, :string
    field :created_at, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:tag, :title, :category, :content, :created_at, :description])
    |> validate_required([:tag, :title, :category, :content, :created_at, :description])
  end
end
