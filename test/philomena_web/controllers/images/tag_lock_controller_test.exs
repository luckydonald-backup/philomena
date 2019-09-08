defmodule PhilomenaWeb.Images.TagLockControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Images

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:tag_lock) do
    {:ok, tag_lock} = Images.create_tag_lock(@create_attrs)
    tag_lock
  end

  describe "index" do
    test "lists all tag_locks", %{conn: conn} do
      conn = get(conn, Routes.images_tag_lock_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Tag locks"
    end
  end

  describe "new tag_lock" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.images_tag_lock_path(conn, :new))
      assert html_response(conn, 200) =~ "New Tag lock"
    end
  end

  describe "create tag_lock" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.images_tag_lock_path(conn, :create), tag_lock: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.images_tag_lock_path(conn, :show, id)

      conn = get(conn, Routes.images_tag_lock_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Tag lock"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.images_tag_lock_path(conn, :create), tag_lock: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Tag lock"
    end
  end

  describe "edit tag_lock" do
    setup [:create_tag_lock]

    test "renders form for editing chosen tag_lock", %{conn: conn, tag_lock: tag_lock} do
      conn = get(conn, Routes.images_tag_lock_path(conn, :edit, tag_lock))
      assert html_response(conn, 200) =~ "Edit Tag lock"
    end
  end

  describe "update tag_lock" do
    setup [:create_tag_lock]

    test "redirects when data is valid", %{conn: conn, tag_lock: tag_lock} do
      conn = put(conn, Routes.images_tag_lock_path(conn, :update, tag_lock), tag_lock: @update_attrs)
      assert redirected_to(conn) == Routes.images_tag_lock_path(conn, :show, tag_lock)

      conn = get(conn, Routes.images_tag_lock_path(conn, :show, tag_lock))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, tag_lock: tag_lock} do
      conn = put(conn, Routes.images_tag_lock_path(conn, :update, tag_lock), tag_lock: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Tag lock"
    end
  end

  describe "delete tag_lock" do
    setup [:create_tag_lock]

    test "deletes chosen tag_lock", %{conn: conn, tag_lock: tag_lock} do
      conn = delete(conn, Routes.images_tag_lock_path(conn, :delete, tag_lock))
      assert redirected_to(conn) == Routes.images_tag_lock_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.images_tag_lock_path(conn, :show, tag_lock))
      end
    end
  end

  defp create_tag_lock(_) do
    tag_lock = fixture(:tag_lock)
    {:ok, tag_lock: tag_lock}
  end
end
