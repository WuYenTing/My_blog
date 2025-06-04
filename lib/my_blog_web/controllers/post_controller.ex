defmodule MyBlogWeb.PostController do
  use MyBlogWeb, :controller
  def index(conn, _params) do
    posts = [
      %{
        id: 1,
        tag: "test",
        title: "first",
        content: "first content",
        category: "None",
        inserted_at: "20250604"
      },
      %{
        id: 2,
        tag: "test",
        title: "second",
        content: "second content",
        category: "None",
        inserted_at: "20250604"
      }
    ]
    render(conn, "index.json", posts: posts)
  end
end
