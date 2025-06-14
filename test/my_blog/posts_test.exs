defmodule MyBlog.PostsTest do
  use MyBlog.DataCase

  alias MyBlog.Posts

  describe "posts" do
    alias MyBlog.Posts.Post

    import MyBlog.PostsFixtures

    @invalid_attrs %{tag: nil, description: nil, title: nil, category: nil, content: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Posts.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Posts.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{tag: "some tag", description: "some description", title: "some title", category: "some category", content: "some content"}

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
      assert post.tag == "some tag"
      assert post.description == "some description"
      assert post.title == "some title"
      assert post.category == "some category"
      assert post.content == "some content"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{tag: "some updated tag", description: "some updated description", title: "some updated title", category: "some updated category", content: "some updated content"}

      assert {:ok, %Post{} = post} = Posts.update_post(post, update_attrs)
      assert post.tag == "some updated tag"
      assert post.description == "some updated description"
      assert post.title == "some updated title"
      assert post.category == "some updated category"
      assert post.content == "some updated content"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Posts.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end
end
