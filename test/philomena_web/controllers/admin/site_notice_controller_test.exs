defmodule PhilomenaWeb.Admin.SiteNoticeControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.SiteNotices

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:site_notice) do
    {:ok, site_notice} = SiteNotices.create_site_notice(@create_attrs)
    site_notice
  end

  describe "index" do
    test "lists all site_notices", %{conn: conn} do
      conn = get(conn, Routes.admin_site_notice_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Site notices"
    end
  end

  describe "new site_notice" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.admin_site_notice_path(conn, :new))
      assert html_response(conn, 200) =~ "New Site notice"
    end
  end

  describe "create site_notice" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.admin_site_notice_path(conn, :create), site_notice: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_site_notice_path(conn, :show, id)

      conn = get(conn, Routes.admin_site_notice_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Site notice"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admin_site_notice_path(conn, :create), site_notice: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Site notice"
    end
  end

  describe "edit site_notice" do
    setup [:create_site_notice]

    test "renders form for editing chosen site_notice", %{conn: conn, site_notice: site_notice} do
      conn = get(conn, Routes.admin_site_notice_path(conn, :edit, site_notice))
      assert html_response(conn, 200) =~ "Edit Site notice"
    end
  end

  describe "update site_notice" do
    setup [:create_site_notice]

    test "redirects when data is valid", %{conn: conn, site_notice: site_notice} do
      conn = put(conn, Routes.admin_site_notice_path(conn, :update, site_notice), site_notice: @update_attrs)
      assert redirected_to(conn) == Routes.admin_site_notice_path(conn, :show, site_notice)

      conn = get(conn, Routes.admin_site_notice_path(conn, :show, site_notice))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, site_notice: site_notice} do
      conn = put(conn, Routes.admin_site_notice_path(conn, :update, site_notice), site_notice: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Site notice"
    end
  end

  describe "delete site_notice" do
    setup [:create_site_notice]

    test "deletes chosen site_notice", %{conn: conn, site_notice: site_notice} do
      conn = delete(conn, Routes.admin_site_notice_path(conn, :delete, site_notice))
      assert redirected_to(conn) == Routes.admin_site_notice_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.admin_site_notice_path(conn, :show, site_notice))
      end
    end
  end

  defp create_site_notice(_) do
    site_notice = fixture(:site_notice)
    {:ok, site_notice: site_notice}
  end
end
