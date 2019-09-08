defmodule PhilomenaWeb.Admin.Reports.CloseControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Reports

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:close) do
    {:ok, close} = Reports.create_close(@create_attrs)
    close
  end

  describe "index" do
    test "lists all reports", %{conn: conn} do
      conn = get(conn, Routes.admin_reports_close_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Reports"
    end
  end

  describe "new close" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.admin_reports_close_path(conn, :new))
      assert html_response(conn, 200) =~ "New Close"
    end
  end

  describe "create close" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.admin_reports_close_path(conn, :create), close: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_reports_close_path(conn, :show, id)

      conn = get(conn, Routes.admin_reports_close_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Close"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admin_reports_close_path(conn, :create), close: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Close"
    end
  end

  describe "edit close" do
    setup [:create_close]

    test "renders form for editing chosen close", %{conn: conn, close: close} do
      conn = get(conn, Routes.admin_reports_close_path(conn, :edit, close))
      assert html_response(conn, 200) =~ "Edit Close"
    end
  end

  describe "update close" do
    setup [:create_close]

    test "redirects when data is valid", %{conn: conn, close: close} do
      conn = put(conn, Routes.admin_reports_close_path(conn, :update, close), close: @update_attrs)
      assert redirected_to(conn) == Routes.admin_reports_close_path(conn, :show, close)

      conn = get(conn, Routes.admin_reports_close_path(conn, :show, close))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, close: close} do
      conn = put(conn, Routes.admin_reports_close_path(conn, :update, close), close: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Close"
    end
  end

  describe "delete close" do
    setup [:create_close]

    test "deletes chosen close", %{conn: conn, close: close} do
      conn = delete(conn, Routes.admin_reports_close_path(conn, :delete, close))
      assert redirected_to(conn) == Routes.admin_reports_close_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.admin_reports_close_path(conn, :show, close))
      end
    end
  end

  defp create_close(_) do
    close = fixture(:close)
    {:ok, close: close}
  end
end
