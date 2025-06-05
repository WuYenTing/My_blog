defmodule MyBlog.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MyBlog.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        category: "some category",
        content: "some content",
        created_at: "some created_at",
        description: "some description",
        tag: "some tag",
        title: "some title"
      })
      |> MyBlog.Posts.create_post()

    post
  end
end
