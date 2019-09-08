defmodule PhilomenaWeb.Images.WatchedControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Images

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:watched) do
    {:ok, watched} = Images.create_watched(@create_attrs)
    watched
  end

  describe "index" do
    test "lists all watched", %{conn: conn} do
      conn = get(conn, Routes.images_watched_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Watched"
    end
  end

  describe "new watched" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.images_watched_path(conn, :new))
      assert html_response(conn, 200) =~ "New Watched"
    end
  end

  describe "create watched" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.images_watched_path(conn, :create), watched: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.images_watched_path(conn, :show, id)

      conn = get(conn, Routes.images_watched_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Watched"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.images_watched_path(conn, :create), watched: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Watched"
    end
  end

  describe "edit watched" do
    setup [:create_watched]

    test "renders form for editing chosen watched", %{conn: conn, watched: watched} do
      conn = get(conn, Routes.images_watched_path(conn, :edit, watched))
      assert html_response(conn, 200) =~ "Edit Watched"
    end
  end

  describe "update watched" do
    setup [:create_watched]

    test "redirects when data is valid", %{conn: conn, watched: watched} do
      conn = put(conn, Routes.images_watched_path(conn, :update, watched), watched: @update_attrs)
      assert redirected_to(conn) == Routes.images_watched_path(conn, :show, watched)

      conn = get(conn, Routes.images_watched_path(conn, :show, watched))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, watched: watched} do
      conn = put(conn, Routes.images_watched_path(conn, :update, watched), watched: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Watched"
    end
  end

  describe "delete watched" do
    setup [:create_watched]

    test "deletes chosen watched", %{conn: conn, watched: watched} do
      conn = delete(conn, Routes.images_watched_path(conn, :delete, watched))
      assert redirected_to(conn) == Routes.images_watched_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.images_watched_path(conn, :show, watched))
      end
    end
  end

  defp create_watched(_) do
    watched = fixture(:watched)
    {:ok, watched: watched}
  end
end
