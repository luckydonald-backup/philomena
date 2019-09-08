defmodule PhilomenaWeb.ForumControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Forums

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:forum) do
    {:ok, forum} = Forums.create_forum(@create_attrs)
    forum
  end

  describe "index" do
    test "lists all forums", %{conn: conn} do
      conn = get(conn, Routes.forum_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Forums"
    end
  end

  describe "new forum" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.forum_path(conn, :new))
      assert html_response(conn, 200) =~ "New Forum"
    end
  end

  describe "create forum" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.forum_path(conn, :create), forum: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.forum_path(conn, :show, id)

      conn = get(conn, Routes.forum_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Forum"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.forum_path(conn, :create), forum: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Forum"
    end
  end

  describe "edit forum" do
    setup [:create_forum]

    test "renders form for editing chosen forum", %{conn: conn, forum: forum} do
      conn = get(conn, Routes.forum_path(conn, :edit, forum))
      assert html_response(conn, 200) =~ "Edit Forum"
    end
  end

  describe "update forum" do
    setup [:create_forum]

    test "redirects when data is valid", %{conn: conn, forum: forum} do
      conn = put(conn, Routes.forum_path(conn, :update, forum), forum: @update_attrs)
      assert redirected_to(conn) == Routes.forum_path(conn, :show, forum)

      conn = get(conn, Routes.forum_path(conn, :show, forum))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, forum: forum} do
      conn = put(conn, Routes.forum_path(conn, :update, forum), forum: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Forum"
    end
  end

  describe "delete forum" do
    setup [:create_forum]

    test "deletes chosen forum", %{conn: conn, forum: forum} do
      conn = delete(conn, Routes.forum_path(conn, :delete, forum))
      assert redirected_to(conn) == Routes.forum_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.forum_path(conn, :show, forum))
      end
    end
  end

  defp create_forum(_) do
    forum = fixture(:forum)
    {:ok, forum: forum}
  end
end
