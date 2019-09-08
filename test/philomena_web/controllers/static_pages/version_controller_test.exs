defmodule PhilomenaWeb.StaticPages.VersionControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.StaticPage

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:version) do
    {:ok, version} = StaticPage.create_version(@create_attrs)
    version
  end

  describe "index" do
    test "lists all static_page_versions", %{conn: conn} do
      conn = get(conn, Routes.static_pages_version_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Static page versions"
    end
  end

  describe "new version" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.static_pages_version_path(conn, :new))
      assert html_response(conn, 200) =~ "New Version"
    end
  end

  describe "create version" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.static_pages_version_path(conn, :create), version: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.static_pages_version_path(conn, :show, id)

      conn = get(conn, Routes.static_pages_version_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Version"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.static_pages_version_path(conn, :create), version: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Version"
    end
  end

  describe "edit version" do
    setup [:create_version]

    test "renders form for editing chosen version", %{conn: conn, version: version} do
      conn = get(conn, Routes.static_pages_version_path(conn, :edit, version))
      assert html_response(conn, 200) =~ "Edit Version"
    end
  end

  describe "update version" do
    setup [:create_version]

    test "redirects when data is valid", %{conn: conn, version: version} do
      conn = put(conn, Routes.static_pages_version_path(conn, :update, version), version: @update_attrs)
      assert redirected_to(conn) == Routes.static_pages_version_path(conn, :show, version)

      conn = get(conn, Routes.static_pages_version_path(conn, :show, version))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, version: version} do
      conn = put(conn, Routes.static_pages_version_path(conn, :update, version), version: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Version"
    end
  end

  describe "delete version" do
    setup [:create_version]

    test "deletes chosen version", %{conn: conn, version: version} do
      conn = delete(conn, Routes.static_pages_version_path(conn, :delete, version))
      assert redirected_to(conn) == Routes.static_pages_version_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.static_pages_version_path(conn, :show, version))
      end
    end
  end

  defp create_version(_) do
    version = fixture(:version)
    {:ok, version: version}
  end
end
