defmodule PhilomenaWeb.DuplicateReports.AcceptControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.DuplicateReports

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:accept) do
    {:ok, accept} = DuplicateReports.create_accept(@create_attrs)
    accept
  end

  describe "index" do
    test "lists all accept", %{conn: conn} do
      conn = get(conn, Routes.duplicate_reports_accept_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Accept"
    end
  end

  describe "new accept" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.duplicate_reports_accept_path(conn, :new))
      assert html_response(conn, 200) =~ "New Accept"
    end
  end

  describe "create accept" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.duplicate_reports_accept_path(conn, :create), accept: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.duplicate_reports_accept_path(conn, :show, id)

      conn = get(conn, Routes.duplicate_reports_accept_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Accept"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.duplicate_reports_accept_path(conn, :create), accept: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Accept"
    end
  end

  describe "edit accept" do
    setup [:create_accept]

    test "renders form for editing chosen accept", %{conn: conn, accept: accept} do
      conn = get(conn, Routes.duplicate_reports_accept_path(conn, :edit, accept))
      assert html_response(conn, 200) =~ "Edit Accept"
    end
  end

  describe "update accept" do
    setup [:create_accept]

    test "redirects when data is valid", %{conn: conn, accept: accept} do
      conn = put(conn, Routes.duplicate_reports_accept_path(conn, :update, accept), accept: @update_attrs)
      assert redirected_to(conn) == Routes.duplicate_reports_accept_path(conn, :show, accept)

      conn = get(conn, Routes.duplicate_reports_accept_path(conn, :show, accept))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, accept: accept} do
      conn = put(conn, Routes.duplicate_reports_accept_path(conn, :update, accept), accept: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Accept"
    end
  end

  describe "delete accept" do
    setup [:create_accept]

    test "deletes chosen accept", %{conn: conn, accept: accept} do
      conn = delete(conn, Routes.duplicate_reports_accept_path(conn, :delete, accept))
      assert redirected_to(conn) == Routes.duplicate_reports_accept_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.duplicate_reports_accept_path(conn, :show, accept))
      end
    end
  end

  defp create_accept(_) do
    accept = fixture(:accept)
    {:ok, accept: accept}
  end
end
