defmodule PhilomenaWeb.Profiles.SourceChangeControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Profiles

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:source_change) do
    {:ok, source_change} = Profiles.create_source_change(@create_attrs)
    source_change
  end

  describe "index" do
    test "lists all source_changes", %{conn: conn} do
      conn = get(conn, Routes.profiles_source_change_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Source changes"
    end
  end

  describe "new source_change" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.profiles_source_change_path(conn, :new))
      assert html_response(conn, 200) =~ "New Source change"
    end
  end

  describe "create source_change" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.profiles_source_change_path(conn, :create), source_change: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.profiles_source_change_path(conn, :show, id)

      conn = get(conn, Routes.profiles_source_change_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Source change"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.profiles_source_change_path(conn, :create), source_change: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Source change"
    end
  end

  describe "edit source_change" do
    setup [:create_source_change]

    test "renders form for editing chosen source_change", %{conn: conn, source_change: source_change} do
      conn = get(conn, Routes.profiles_source_change_path(conn, :edit, source_change))
      assert html_response(conn, 200) =~ "Edit Source change"
    end
  end

  describe "update source_change" do
    setup [:create_source_change]

    test "redirects when data is valid", %{conn: conn, source_change: source_change} do
      conn = put(conn, Routes.profiles_source_change_path(conn, :update, source_change), source_change: @update_attrs)
      assert redirected_to(conn) == Routes.profiles_source_change_path(conn, :show, source_change)

      conn = get(conn, Routes.profiles_source_change_path(conn, :show, source_change))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, source_change: source_change} do
      conn = put(conn, Routes.profiles_source_change_path(conn, :update, source_change), source_change: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Source change"
    end
  end

  describe "delete source_change" do
    setup [:create_source_change]

    test "deletes chosen source_change", %{conn: conn, source_change: source_change} do
      conn = delete(conn, Routes.profiles_source_change_path(conn, :delete, source_change))
      assert redirected_to(conn) == Routes.profiles_source_change_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.profiles_source_change_path(conn, :show, source_change))
      end
    end
  end

  defp create_source_change(_) do
    source_change = fixture(:source_change)
    {:ok, source_change: source_change}
  end
end
