defmodule MyBlogWeb.PostHtml do
  use MyBlogWeb, :html
  def render("index.json", %{posts: posts}) do

  end

  def render("post.json", %{post: post}) do
    %{
        id: post.id,
        tag: post.tag,
        title: post.title,
        content: post.content,
        category: post.category,
        created_at: post.inserted_at,
      }
  end

  def render_many(%{posts: posts}, "post.json") do

  end
end
