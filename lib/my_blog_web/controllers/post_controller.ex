defmodule MyBlogWeb.PostController do
  use MyBlogWeb, :controller

  alias MyBlog.Posts

  action_fallback MyBlogWeb.FallbackController

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, :index, posts: posts)
  end

  # def create(conn, %{"data" => post_params}) do
  #   user = Pow.Plug.current_user(conn)

  #   with {:ok, %Post{} = post} <- Posts.create_post(user, post_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", ~p"/api/posts/#{post}")
  #     |> render(:show, post: post)
  #   end
  # end

  def show(conn, %{"id" => id}) do
    with {:ok, post} <- Posts.get_post(id) do
      render(conn, :show, post: post)
    end
  end

  # def update(conn, %{"id" => id, "data" => post_params}) do
  #   with {:ok, post} <- Posts.get_post(id) do
  #     with {:ok, %Post{} = post} <- Posts.update_post(post, post_params) do
  #       render(conn, :show, post: post)
  #     end
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   with {:ok, post} <- Posts.get_post(id) do
  #     with {:ok, %Post{}} <- Posts.delete_post(post) do
  #       send_resp(conn, :no_content, "")
  #     end
  #   end
  # end
end
