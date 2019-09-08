defmodule PhilomenaWeb.Images.ReportingControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Images

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:reporting) do
    {:ok, reporting} = Images.create_reporting(@create_attrs)
    reporting
  end

  describe "index" do
    test "lists all reporting", %{conn: conn} do
      conn = get(conn, Routes.images_reporting_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Reporting"
    end
  end

  describe "new reporting" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.images_reporting_path(conn, :new))
      assert html_response(conn, 200) =~ "New Reporting"
    end
  end

  describe "create reporting" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.images_reporting_path(conn, :create), reporting: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.images_reporting_path(conn, :show, id)

      conn = get(conn, Routes.images_reporting_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Reporting"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.images_reporting_path(conn, :create), reporting: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Reporting"
    end
  end

  describe "edit reporting" do
    setup [:create_reporting]

    test "renders form for editing chosen reporting", %{conn: conn, reporting: reporting} do
      conn = get(conn, Routes.images_reporting_path(conn, :edit, reporting))
      assert html_response(conn, 200) =~ "Edit Reporting"
    end
  end

  describe "update reporting" do
    setup [:create_reporting]

    test "redirects when data is valid", %{conn: conn, reporting: reporting} do
      conn = put(conn, Routes.images_reporting_path(conn, :update, reporting), reporting: @update_attrs)
      assert redirected_to(conn) == Routes.images_reporting_path(conn, :show, reporting)

      conn = get(conn, Routes.images_reporting_path(conn, :show, reporting))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, reporting: reporting} do
      conn = put(conn, Routes.images_reporting_path(conn, :update, reporting), reporting: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Reporting"
    end
  end

  describe "delete reporting" do
    setup [:create_reporting]

    test "deletes chosen reporting", %{conn: conn, reporting: reporting} do
      conn = delete(conn, Routes.images_reporting_path(conn, :delete, reporting))
      assert redirected_to(conn) == Routes.images_reporting_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.images_reporting_path(conn, :show, reporting))
      end
    end
  end

  defp create_reporting(_) do
    reporting = fixture(:reporting)
    {:ok, reporting: reporting}
  end
end
