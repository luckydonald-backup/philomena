defmodule PhilomenaWeb.StaticPageControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.StaticPages

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:static_page) do
    {:ok, static_page} = StaticPages.create_static_page(@create_attrs)
    static_page
  end

  describe "index" do
    test "lists all static_pages", %{conn: conn} do
      conn = get(conn, Routes.static_page_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Static pages"
    end
  end

  describe "new static_page" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.static_page_path(conn, :new))
      assert html_response(conn, 200) =~ "New Static page"
    end
  end

  describe "create static_page" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.static_page_path(conn, :create), static_page: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.static_page_path(conn, :show, id)

      conn = get(conn, Routes.static_page_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Static page"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.static_page_path(conn, :create), static_page: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Static page"
    end
  end

  describe "edit static_page" do
    setup [:create_static_page]

    test "renders form for editing chosen static_page", %{conn: conn, static_page: static_page} do
      conn = get(conn, Routes.static_page_path(conn, :edit, static_page))
      assert html_response(conn, 200) =~ "Edit Static page"
    end
  end

  describe "update static_page" do
    setup [:create_static_page]

    test "redirects when data is valid", %{conn: conn, static_page: static_page} do
      conn = put(conn, Routes.static_page_path(conn, :update, static_page), static_page: @update_attrs)
      assert redirected_to(conn) == Routes.static_page_path(conn, :show, static_page)

      conn = get(conn, Routes.static_page_path(conn, :show, static_page))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, static_page: static_page} do
      conn = put(conn, Routes.static_page_path(conn, :update, static_page), static_page: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Static page"
    end
  end

  describe "delete static_page" do
    setup [:create_static_page]

    test "deletes chosen static_page", %{conn: conn, static_page: static_page} do
      conn = delete(conn, Routes.static_page_path(conn, :delete, static_page))
      assert redirected_to(conn) == Routes.static_page_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.static_page_path(conn, :show, static_page))
      end
    end
  end

  defp create_static_page(_) do
    static_page = fixture(:static_page)
    {:ok, static_page: static_page}
  end
end
