defmodule PhilomenaWeb.Posts.PostedControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Posts

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:posted) do
    {:ok, posted} = Posts.create_posted(@create_attrs)
    posted
  end

  describe "index" do
    test "lists all posted", %{conn: conn} do
      conn = get(conn, Routes.posts_posted_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Posted"
    end
  end

  describe "new posted" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.posts_posted_path(conn, :new))
      assert html_response(conn, 200) =~ "New Posted"
    end
  end

  describe "create posted" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.posts_posted_path(conn, :create), posted: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.posts_posted_path(conn, :show, id)

      conn = get(conn, Routes.posts_posted_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Posted"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.posts_posted_path(conn, :create), posted: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Posted"
    end
  end

  describe "edit posted" do
    setup [:create_posted]

    test "renders form for editing chosen posted", %{conn: conn, posted: posted} do
      conn = get(conn, Routes.posts_posted_path(conn, :edit, posted))
      assert html_response(conn, 200) =~ "Edit Posted"
    end
  end

  describe "update posted" do
    setup [:create_posted]

    test "redirects when data is valid", %{conn: conn, posted: posted} do
      conn = put(conn, Routes.posts_posted_path(conn, :update, posted), posted: @update_attrs)
      assert redirected_to(conn) == Routes.posts_posted_path(conn, :show, posted)

      conn = get(conn, Routes.posts_posted_path(conn, :show, posted))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, posted: posted} do
      conn = put(conn, Routes.posts_posted_path(conn, :update, posted), posted: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Posted"
    end
  end

  describe "delete posted" do
    setup [:create_posted]

    test "deletes chosen posted", %{conn: conn, posted: posted} do
      conn = delete(conn, Routes.posts_posted_path(conn, :delete, posted))
      assert redirected_to(conn) == Routes.posts_posted_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.posts_posted_path(conn, :show, posted))
      end
    end
  end

  defp create_posted(_) do
    posted = fixture(:posted)
    {:ok, posted: posted}
  end
end
