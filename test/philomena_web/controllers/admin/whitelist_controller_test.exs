defmodule PhilomenaWeb.Admin.WhitelistControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Users

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:whitelist) do
    {:ok, whitelist} = Users.create_whitelist(@create_attrs)
    whitelist
  end

  describe "index" do
    test "lists all user_whitelists", %{conn: conn} do
      conn = get(conn, Routes.admin_whitelist_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing User whitelists"
    end
  end

  describe "new whitelist" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.admin_whitelist_path(conn, :new))
      assert html_response(conn, 200) =~ "New Whitelist"
    end
  end

  describe "create whitelist" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.admin_whitelist_path(conn, :create), whitelist: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_whitelist_path(conn, :show, id)

      conn = get(conn, Routes.admin_whitelist_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Whitelist"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admin_whitelist_path(conn, :create), whitelist: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Whitelist"
    end
  end

  describe "edit whitelist" do
    setup [:create_whitelist]

    test "renders form for editing chosen whitelist", %{conn: conn, whitelist: whitelist} do
      conn = get(conn, Routes.admin_whitelist_path(conn, :edit, whitelist))
      assert html_response(conn, 200) =~ "Edit Whitelist"
    end
  end

  describe "update whitelist" do
    setup [:create_whitelist]

    test "redirects when data is valid", %{conn: conn, whitelist: whitelist} do
      conn = put(conn, Routes.admin_whitelist_path(conn, :update, whitelist), whitelist: @update_attrs)
      assert redirected_to(conn) == Routes.admin_whitelist_path(conn, :show, whitelist)

      conn = get(conn, Routes.admin_whitelist_path(conn, :show, whitelist))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, whitelist: whitelist} do
      conn = put(conn, Routes.admin_whitelist_path(conn, :update, whitelist), whitelist: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Whitelist"
    end
  end

  describe "delete whitelist" do
    setup [:create_whitelist]

    test "deletes chosen whitelist", %{conn: conn, whitelist: whitelist} do
      conn = delete(conn, Routes.admin_whitelist_path(conn, :delete, whitelist))
      assert redirected_to(conn) == Routes.admin_whitelist_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.admin_whitelist_path(conn, :show, whitelist))
      end
    end
  end

  defp create_whitelist(_) do
    whitelist = fixture(:whitelist)
    {:ok, whitelist: whitelist}
  end
end
