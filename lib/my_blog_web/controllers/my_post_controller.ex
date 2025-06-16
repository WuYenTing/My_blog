defmodule MyBlogWeb.MyPostController do
  use MyBlogWeb, :controller

  alias MyBlog.Posts
  alias MyBlog.Posts.Post

  action_fallback MyBlogWeb.FallbackController

  # get_my_posts
  def index(conn, _params) do
    posts =
      conn
      |> Pow.Plug.current_user()
      |> Posts.list_posts()

    conn
    |> put_view(MyBlogWeb.PostJSON)
    |> render(:index, posts: posts)
  end

  def create(conn, %{"data" => post_params}) do
    user = Pow.Plug.current_user(conn)

    with {:ok, %Post{} = post} <- Posts.create_post(user, post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/posts/#{post}")
      |> put_view(MyBlogWeb.PostJSON)
      |> render(:show, post: post)
    end
  end

  def update(conn, %{"id" => id, "data" => post_params}) do
    user = Pow.Plug.current_user(conn)

    with {:ok, post} <- Posts.get_post(user, id) do
      with {:ok, %Post{} = post} <- Posts.update_post(post, post_params) do
        conn
        |> put_view(MyBlogWeb.PostJSON)
        |> render(:show, post: post)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Pow.Plug.current_user(conn)

    with {:ok, post} <- Posts.get_post(user, id) do
      with {:ok, %Post{}} <- Posts.delete_post(post) do
        send_resp(conn, :no_content, "")
      end
    end
  end
end
