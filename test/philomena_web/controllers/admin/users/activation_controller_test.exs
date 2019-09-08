defmodule PhilomenaWeb.Admin.Users.ActivationControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.User

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:activation) do
    {:ok, activation} = User.create_activation(@create_attrs)
    activation
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.admin_users_activation_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Users"
    end
  end

  describe "new activation" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.admin_users_activation_path(conn, :new))
      assert html_response(conn, 200) =~ "New Activation"
    end
  end

  describe "create activation" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.admin_users_activation_path(conn, :create), activation: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_users_activation_path(conn, :show, id)

      conn = get(conn, Routes.admin_users_activation_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Activation"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admin_users_activation_path(conn, :create), activation: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Activation"
    end
  end

  describe "edit activation" do
    setup [:create_activation]

    test "renders form for editing chosen activation", %{conn: conn, activation: activation} do
      conn = get(conn, Routes.admin_users_activation_path(conn, :edit, activation))
      assert html_response(conn, 200) =~ "Edit Activation"
    end
  end

  describe "update activation" do
    setup [:create_activation]

    test "redirects when data is valid", %{conn: conn, activation: activation} do
      conn = put(conn, Routes.admin_users_activation_path(conn, :update, activation), activation: @update_attrs)
      assert redirected_to(conn) == Routes.admin_users_activation_path(conn, :show, activation)

      conn = get(conn, Routes.admin_users_activation_path(conn, :show, activation))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, activation: activation} do
      conn = put(conn, Routes.admin_users_activation_path(conn, :update, activation), activation: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Activation"
    end
  end

  describe "delete activation" do
    setup [:create_activation]

    test "deletes chosen activation", %{conn: conn, activation: activation} do
      conn = delete(conn, Routes.admin_users_activation_path(conn, :delete, activation))
      assert redirected_to(conn) == Routes.admin_users_activation_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.admin_users_activation_path(conn, :show, activation))
      end
    end
  end

  defp create_activation(_) do
    activation = fixture(:activation)
    {:ok, activation: activation}
  end
end
