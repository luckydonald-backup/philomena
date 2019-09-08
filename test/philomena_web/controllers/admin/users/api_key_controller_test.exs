defmodule PhilomenaWeb.Admin.Users.ApiKeyControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.User

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:api_key) do
    {:ok, api_key} = User.create_api_key(@create_attrs)
    api_key
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.admin_users_api_key_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Users"
    end
  end

  describe "new api_key" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.admin_users_api_key_path(conn, :new))
      assert html_response(conn, 200) =~ "New Api key"
    end
  end

  describe "create api_key" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.admin_users_api_key_path(conn, :create), api_key: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_users_api_key_path(conn, :show, id)

      conn = get(conn, Routes.admin_users_api_key_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Api key"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admin_users_api_key_path(conn, :create), api_key: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Api key"
    end
  end

  describe "edit api_key" do
    setup [:create_api_key]

    test "renders form for editing chosen api_key", %{conn: conn, api_key: api_key} do
      conn = get(conn, Routes.admin_users_api_key_path(conn, :edit, api_key))
      assert html_response(conn, 200) =~ "Edit Api key"
    end
  end

  describe "update api_key" do
    setup [:create_api_key]

    test "redirects when data is valid", %{conn: conn, api_key: api_key} do
      conn = put(conn, Routes.admin_users_api_key_path(conn, :update, api_key), api_key: @update_attrs)
      assert redirected_to(conn) == Routes.admin_users_api_key_path(conn, :show, api_key)

      conn = get(conn, Routes.admin_users_api_key_path(conn, :show, api_key))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, api_key: api_key} do
      conn = put(conn, Routes.admin_users_api_key_path(conn, :update, api_key), api_key: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Api key"
    end
  end

  describe "delete api_key" do
    setup [:create_api_key]

    test "deletes chosen api_key", %{conn: conn, api_key: api_key} do
      conn = delete(conn, Routes.admin_users_api_key_path(conn, :delete, api_key))
      assert redirected_to(conn) == Routes.admin_users_api_key_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.admin_users_api_key_path(conn, :show, api_key))
      end
    end
  end

  defp create_api_key(_) do
    api_key = fixture(:api_key)
    {:ok, api_key: api_key}
  end
end
