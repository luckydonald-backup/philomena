defmodule PhilomenaWeb.Images.CommentLockControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Images

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:comment_lock) do
    {:ok, comment_lock} = Images.create_comment_lock(@create_attrs)
    comment_lock
  end

  describe "index" do
    test "lists all comment_locks", %{conn: conn} do
      conn = get(conn, Routes.images_comment_lock_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Comment locks"
    end
  end

  describe "new comment_lock" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.images_comment_lock_path(conn, :new))
      assert html_response(conn, 200) =~ "New Comment lock"
    end
  end

  describe "create comment_lock" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.images_comment_lock_path(conn, :create), comment_lock: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.images_comment_lock_path(conn, :show, id)

      conn = get(conn, Routes.images_comment_lock_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Comment lock"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.images_comment_lock_path(conn, :create), comment_lock: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Comment lock"
    end
  end

  describe "edit comment_lock" do
    setup [:create_comment_lock]

    test "renders form for editing chosen comment_lock", %{conn: conn, comment_lock: comment_lock} do
      conn = get(conn, Routes.images_comment_lock_path(conn, :edit, comment_lock))
      assert html_response(conn, 200) =~ "Edit Comment lock"
    end
  end

  describe "update comment_lock" do
    setup [:create_comment_lock]

    test "redirects when data is valid", %{conn: conn, comment_lock: comment_lock} do
      conn = put(conn, Routes.images_comment_lock_path(conn, :update, comment_lock), comment_lock: @update_attrs)
      assert redirected_to(conn) == Routes.images_comment_lock_path(conn, :show, comment_lock)

      conn = get(conn, Routes.images_comment_lock_path(conn, :show, comment_lock))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, comment_lock: comment_lock} do
      conn = put(conn, Routes.images_comment_lock_path(conn, :update, comment_lock), comment_lock: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Comment lock"
    end
  end

  describe "delete comment_lock" do
    setup [:create_comment_lock]

    test "deletes chosen comment_lock", %{conn: conn, comment_lock: comment_lock} do
      conn = delete(conn, Routes.images_comment_lock_path(conn, :delete, comment_lock))
      assert redirected_to(conn) == Routes.images_comment_lock_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.images_comment_lock_path(conn, :show, comment_lock))
      end
    end
  end

  defp create_comment_lock(_) do
    comment_lock = fixture(:comment_lock)
    {:ok, comment_lock: comment_lock}
  end
end
