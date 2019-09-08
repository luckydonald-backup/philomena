defmodule PhilomenaWeb.DuplicateReports.AcceptReverseControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.DuplicateReports

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:accept_reverse) do
    {:ok, accept_reverse} = DuplicateReports.create_accept_reverse(@create_attrs)
    accept_reverse
  end

  describe "index" do
    test "lists all accept_reverse", %{conn: conn} do
      conn = get(conn, Routes.duplicate_reports_accept_reverse_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Accept reverse"
    end
  end

  describe "new accept_reverse" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.duplicate_reports_accept_reverse_path(conn, :new))
      assert html_response(conn, 200) =~ "New Accept reverse"
    end
  end

  describe "create accept_reverse" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.duplicate_reports_accept_reverse_path(conn, :create), accept_reverse: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.duplicate_reports_accept_reverse_path(conn, :show, id)

      conn = get(conn, Routes.duplicate_reports_accept_reverse_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Accept reverse"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.duplicate_reports_accept_reverse_path(conn, :create), accept_reverse: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Accept reverse"
    end
  end

  describe "edit accept_reverse" do
    setup [:create_accept_reverse]

    test "renders form for editing chosen accept_reverse", %{conn: conn, accept_reverse: accept_reverse} do
      conn = get(conn, Routes.duplicate_reports_accept_reverse_path(conn, :edit, accept_reverse))
      assert html_response(conn, 200) =~ "Edit Accept reverse"
    end
  end

  describe "update accept_reverse" do
    setup [:create_accept_reverse]

    test "redirects when data is valid", %{conn: conn, accept_reverse: accept_reverse} do
      conn = put(conn, Routes.duplicate_reports_accept_reverse_path(conn, :update, accept_reverse), accept_reverse: @update_attrs)
      assert redirected_to(conn) == Routes.duplicate_reports_accept_reverse_path(conn, :show, accept_reverse)

      conn = get(conn, Routes.duplicate_reports_accept_reverse_path(conn, :show, accept_reverse))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, accept_reverse: accept_reverse} do
      conn = put(conn, Routes.duplicate_reports_accept_reverse_path(conn, :update, accept_reverse), accept_reverse: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Accept reverse"
    end
  end

  describe "delete accept_reverse" do
    setup [:create_accept_reverse]

    test "deletes chosen accept_reverse", %{conn: conn, accept_reverse: accept_reverse} do
      conn = delete(conn, Routes.duplicate_reports_accept_reverse_path(conn, :delete, accept_reverse))
      assert redirected_to(conn) == Routes.duplicate_reports_accept_reverse_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.duplicate_reports_accept_reverse_path(conn, :show, accept_reverse))
      end
    end
  end

  defp create_accept_reverse(_) do
    accept_reverse = fixture(:accept_reverse)
    {:ok, accept_reverse: accept_reverse}
  end
end
