defmodule MyBlogWeb.RegistrationController do
  use MyBlogWeb, :controller

  alias Ecto.Changeset
  alias MyBlogWeb.ChangesetJSON

  def create(conn, %{"user" => user_params}) do
    conn
    |> Pow.Plug.create_user(user_params)
    |> case do
      {:ok, _user, conn} ->
        json(conn, %{
          data: %{
            access_token: conn.private.api_access_token,
            renewal_token: conn.private.api_renewal_token,
            expired_at: conn.private.api_access_token_expired_at
          }
        })

      {:error, changeset, conn} ->
        errors = Changeset.traverse_errors(changeset, &ChangesetJSON.error/1)

        conn
        |> put_status(500)
        |> json(%{error: %{status: 500, message: "Couldn't create user", errors: errors}})
    end
  end
end
