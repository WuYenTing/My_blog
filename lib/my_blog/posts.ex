defmodule MyBlog.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias MyBlog.Repo

  alias MyBlog.Posts.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post, order_by: [desc: :inserted_at])
  end

  def list_posts(%MyBlog.Users.User{id: user_id}) do
    Repo.all(from p in Post, where: p.user_id == ^user_id, preload: [:user], order_by: [desc: :inserted_at])
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)
  """
  def get_post(id) do
    case Repo.get(Post, id) do
      nil -> {:error, :not_found}
      post -> {:ok, post}
    end
  end

  def get_post(%MyBlog.Users.User{id: user_id}, id) do
    q = from p in Post, where: p.user_id == ^user_id, preload: [:user]
    case Repo.get(q, id) do
      nil -> {:error, :not_found}
      post -> {:ok, post}
    end
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(%MyBlog.Users.User{} = user, attrs \\ %{}) do
    with {:ok, post} <-
      %Post{}
      |> Post.changeset(attrs)
      |> Ecto.Changeset.put_assoc(:user, user)
      |> Repo.insert()
    do
      {:ok, Repo.preload(post, [:user])}
    end
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end
end
