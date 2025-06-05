defmodule MyBlogWeb.PostJSON do
  alias MyBlog.Posts.Post

  @doc """
  Renders a list of posts.
  """
  def index(%{posts: posts}) do
    %{data: for(post <- posts, do: data(post))}
  end

  @doc """
  Renders a single post.
  """
  def show(%{post: post}) do
    %{data: data(post)}
  end

  defp data(%Post{} = post) do
    %{
      id: post.id,
      tag: post.tag,
      title: post.title,
      category: post.category,
      content: post.content,
      created_at: post.created_at,
      description: post.description
    }
  end
end
