defmodule PhilomenaWeb.Filters.CurrentControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Filters

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:current) do
    {:ok, current} = Filters.create_current(@create_attrs)
    current
  end

  describe "index" do
    test "lists all current", %{conn: conn} do
      conn = get(conn, Routes.filters_current_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Current"
    end
  end

  describe "new current" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.filters_current_path(conn, :new))
      assert html_response(conn, 200) =~ "New Current"
    end
  end

  describe "create current" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.filters_current_path(conn, :create), current: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.filters_current_path(conn, :show, id)

      conn = get(conn, Routes.filters_current_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Current"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.filters_current_path(conn, :create), current: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Current"
    end
  end

  describe "edit current" do
    setup [:create_current]

    test "renders form for editing chosen current", %{conn: conn, current: current} do
      conn = get(conn, Routes.filters_current_path(conn, :edit, current))
      assert html_response(conn, 200) =~ "Edit Current"
    end
  end

  describe "update current" do
    setup [:create_current]

    test "redirects when data is valid", %{conn: conn, current: current} do
      conn = put(conn, Routes.filters_current_path(conn, :update, current), current: @update_attrs)
      assert redirected_to(conn) == Routes.filters_current_path(conn, :show, current)

      conn = get(conn, Routes.filters_current_path(conn, :show, current))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, current: current} do
      conn = put(conn, Routes.filters_current_path(conn, :update, current), current: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Current"
    end
  end

  describe "delete current" do
    setup [:create_current]

    test "deletes chosen current", %{conn: conn, current: current} do
      conn = delete(conn, Routes.filters_current_path(conn, :delete, current))
      assert redirected_to(conn) == Routes.filters_current_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.filters_current_path(conn, :show, current))
      end
    end
  end

  defp create_current(_) do
    current = fixture(:current)
    {:ok, current: current}
  end
end
