defmodule PhilomenaWeb.Tags.WatchControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Tags

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:watch) do
    {:ok, watch} = Tags.create_watch(@create_attrs)
    watch
  end

  describe "index" do
    test "lists all watches", %{conn: conn} do
      conn = get(conn, Routes.tags_watch_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Watches"
    end
  end

  describe "new watch" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.tags_watch_path(conn, :new))
      assert html_response(conn, 200) =~ "New Watch"
    end
  end

  describe "create watch" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.tags_watch_path(conn, :create), watch: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.tags_watch_path(conn, :show, id)

      conn = get(conn, Routes.tags_watch_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Watch"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.tags_watch_path(conn, :create), watch: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Watch"
    end
  end

  describe "edit watch" do
    setup [:create_watch]

    test "renders form for editing chosen watch", %{conn: conn, watch: watch} do
      conn = get(conn, Routes.tags_watch_path(conn, :edit, watch))
      assert html_response(conn, 200) =~ "Edit Watch"
    end
  end

  describe "update watch" do
    setup [:create_watch]

    test "redirects when data is valid", %{conn: conn, watch: watch} do
      conn = put(conn, Routes.tags_watch_path(conn, :update, watch), watch: @update_attrs)
      assert redirected_to(conn) == Routes.tags_watch_path(conn, :show, watch)

      conn = get(conn, Routes.tags_watch_path(conn, :show, watch))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, watch: watch} do
      conn = put(conn, Routes.tags_watch_path(conn, :update, watch), watch: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Watch"
    end
  end

  describe "delete watch" do
    setup [:create_watch]

    test "deletes chosen watch", %{conn: conn, watch: watch} do
      conn = delete(conn, Routes.tags_watch_path(conn, :delete, watch))
      assert redirected_to(conn) == Routes.tags_watch_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.tags_watch_path(conn, :show, watch))
      end
    end
  end

  defp create_watch(_) do
    watch = fixture(:watch)
    {:ok, watch: watch}
  end
end
