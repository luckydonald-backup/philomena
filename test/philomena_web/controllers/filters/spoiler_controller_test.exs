defmodule PhilomenaWeb.Filters.SpoilerControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Filters

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:spoiler) do
    {:ok, spoiler} = Filters.create_spoiler(@create_attrs)
    spoiler
  end

  describe "index" do
    test "lists all spoiler", %{conn: conn} do
      conn = get(conn, Routes.filters_spoiler_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Hide"
    end
  end

  describe "new spoiler" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.filters_spoiler_path(conn, :new))
      assert html_response(conn, 200) =~ "New Hide"
    end
  end

  describe "create spoiler" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.filters_spoiler_path(conn, :create), spoiler: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.filters_spoiler_path(conn, :show, id)

      conn = get(conn, Routes.filters_spoiler_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Hide"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.filters_spoiler_path(conn, :create), spoiler: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Hide"
    end
  end

  describe "edit spoiler" do
    setup [:create_spoiler]

    test "renders form for editing chosen spoiler", %{conn: conn, spoiler: spoiler} do
      conn = get(conn, Routes.filters_spoiler_path(conn, :edit, spoiler))
      assert html_response(conn, 200) =~ "Edit Hide"
    end
  end

  describe "update spoiler" do
    setup [:create_spoiler]

    test "redirects when data is valid", %{conn: conn, spoiler: spoiler} do
      conn = put(conn, Routes.filters_spoiler_path(conn, :update, spoiler), spoiler: @update_attrs)
      assert redirected_to(conn) == Routes.filters_spoiler_path(conn, :show, spoiler)

      conn = get(conn, Routes.filters_spoiler_path(conn, :show, spoiler))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, spoiler: spoiler} do
      conn = put(conn, Routes.filters_spoiler_path(conn, :update, spoiler), spoiler: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Hide"
    end
  end

  describe "delete spoiler" do
    setup [:create_spoiler]

    test "deletes chosen spoiler", %{conn: conn, spoiler: spoiler} do
      conn = delete(conn, Routes.filters_spoiler_path(conn, :delete, spoiler))
      assert redirected_to(conn) == Routes.filters_spoiler_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.filters_spoiler_path(conn, :show, spoiler))
      end
    end
  end

  defp create_spoiler(_) do
    spoiler = fixture(:spoiler)
    {:ok, spoiler: spoiler}
  end
end
