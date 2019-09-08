defmodule PhilomenaWeb.Admin.Users.WipeControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.User

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:wipe) do
    {:ok, wipe} = User.create_wipe(@create_attrs)
    wipe
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.admin_users_wipe_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Users"
    end
  end

  describe "new wipe" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.admin_users_wipe_path(conn, :new))
      assert html_response(conn, 200) =~ "New Wipe"
    end
  end

  describe "create wipe" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.admin_users_wipe_path(conn, :create), wipe: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_users_wipe_path(conn, :show, id)

      conn = get(conn, Routes.admin_users_wipe_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Wipe"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admin_users_wipe_path(conn, :create), wipe: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Wipe"
    end
  end

  describe "edit wipe" do
    setup [:create_wipe]

    test "renders form for editing chosen wipe", %{conn: conn, wipe: wipe} do
      conn = get(conn, Routes.admin_users_wipe_path(conn, :edit, wipe))
      assert html_response(conn, 200) =~ "Edit Wipe"
    end
  end

  describe "update wipe" do
    setup [:create_wipe]

    test "redirects when data is valid", %{conn: conn, wipe: wipe} do
      conn = put(conn, Routes.admin_users_wipe_path(conn, :update, wipe), wipe: @update_attrs)
      assert redirected_to(conn) == Routes.admin_users_wipe_path(conn, :show, wipe)

      conn = get(conn, Routes.admin_users_wipe_path(conn, :show, wipe))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, wipe: wipe} do
      conn = put(conn, Routes.admin_users_wipe_path(conn, :update, wipe), wipe: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Wipe"
    end
  end

  describe "delete wipe" do
    setup [:create_wipe]

    test "deletes chosen wipe", %{conn: conn, wipe: wipe} do
      conn = delete(conn, Routes.admin_users_wipe_path(conn, :delete, wipe))
      assert redirected_to(conn) == Routes.admin_users_wipe_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.admin_users_wipe_path(conn, :show, wipe))
      end
    end
  end

  defp create_wipe(_) do
    wipe = fixture(:wipe)
    {:ok, wipe: wipe}
  end
end
