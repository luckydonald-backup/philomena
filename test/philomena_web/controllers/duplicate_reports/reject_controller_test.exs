defmodule PhilomenaWeb.DuplicateReports.RejectControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.DuplicateReports

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:reject) do
    {:ok, reject} = DuplicateReports.create_reject(@create_attrs)
    reject
  end

  describe "index" do
    test "lists all reject", %{conn: conn} do
      conn = get(conn, Routes.duplicate_reports_reject_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Reject"
    end
  end

  describe "new reject" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.duplicate_reports_reject_path(conn, :new))
      assert html_response(conn, 200) =~ "New Reject"
    end
  end

  describe "create reject" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.duplicate_reports_reject_path(conn, :create), reject: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.duplicate_reports_reject_path(conn, :show, id)

      conn = get(conn, Routes.duplicate_reports_reject_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Reject"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.duplicate_reports_reject_path(conn, :create), reject: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Reject"
    end
  end

  describe "edit reject" do
    setup [:create_reject]

    test "renders form for editing chosen reject", %{conn: conn, reject: reject} do
      conn = get(conn, Routes.duplicate_reports_reject_path(conn, :edit, reject))
      assert html_response(conn, 200) =~ "Edit Reject"
    end
  end

  describe "update reject" do
    setup [:create_reject]

    test "redirects when data is valid", %{conn: conn, reject: reject} do
      conn = put(conn, Routes.duplicate_reports_reject_path(conn, :update, reject), reject: @update_attrs)
      assert redirected_to(conn) == Routes.duplicate_reports_reject_path(conn, :show, reject)

      conn = get(conn, Routes.duplicate_reports_reject_path(conn, :show, reject))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, reject: reject} do
      conn = put(conn, Routes.duplicate_reports_reject_path(conn, :update, reject), reject: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Reject"
    end
  end

  describe "delete reject" do
    setup [:create_reject]

    test "deletes chosen reject", %{conn: conn, reject: reject} do
      conn = delete(conn, Routes.duplicate_reports_reject_path(conn, :delete, reject))
      assert redirected_to(conn) == Routes.duplicate_reports_reject_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.duplicate_reports_reject_path(conn, :show, reject))
      end
    end
  end

  defp create_reject(_) do
    reject = fixture(:reject)
    {:ok, reject: reject}
  end
end
