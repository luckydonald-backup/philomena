defmodule PhilomenaWeb.Profiles.AliasControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Profiles

  @create_attrs %{order: "some order"}
  @update_attrs %{order: "some updated order"}
  @invalid_attrs %{order: nil}

  def fixture(:alias) do
    {:ok, alias} = Profiles.create_alias(@create_attrs)
    alias
  end

  describe "index" do
    test "lists all aliases", %{conn: conn} do
      conn = get(conn, Routes.profiles_alias_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Aliases"
    end
  end

  describe "new alias" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.profiles_alias_path(conn, :new))
      assert html_response(conn, 200) =~ "New Alias"
    end
  end

  describe "create alias" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.profiles_alias_path(conn, :create), alias: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.profiles_alias_path(conn, :show, id)

      conn = get(conn, Routes.profiles_alias_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Alias"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.profiles_alias_path(conn, :create), alias: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Alias"
    end
  end

  describe "edit alias" do
    setup [:create_alias]

    test "renders form for editing chosen alias", %{conn: conn, alias: alias} do
      conn = get(conn, Routes.profiles_alias_path(conn, :edit, alias))
      assert html_response(conn, 200) =~ "Edit Alias"
    end
  end

  describe "update alias" do
    setup [:create_alias]

    test "redirects when data is valid", %{conn: conn, alias: alias} do
      conn = put(conn, Routes.profiles_alias_path(conn, :update, alias), alias: @update_attrs)
      assert redirected_to(conn) == Routes.profiles_alias_path(conn, :show, alias)

      conn = get(conn, Routes.profiles_alias_path(conn, :show, alias))
      assert html_response(conn, 200) =~ "some updated order"
    end

    test "renders errors when data is invalid", %{conn: conn, alias: alias} do
      conn = put(conn, Routes.profiles_alias_path(conn, :update, alias), alias: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Alias"
    end
  end

  describe "delete alias" do
    setup [:create_alias]

    test "deletes chosen alias", %{conn: conn, alias: alias} do
      conn = delete(conn, Routes.profiles_alias_path(conn, :delete, alias))
      assert redirected_to(conn) == Routes.profiles_alias_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.profiles_alias_path(conn, :show, alias))
      end
    end
  end

  defp create_alias(_) do
    alias = fixture(:alias)
    {:ok, alias: alias}
  end
end
