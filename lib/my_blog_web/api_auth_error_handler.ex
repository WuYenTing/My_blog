defmodule MyBlogWeb.APIAuthErrorHandler do
  use MyBlogWeb, :controller

  def call(conn, :not_authenticated) do
    conn
    |> put_status(401)
    |> json(%{error: %{code: 401, message: "Not authenticated"}})
  end
end
