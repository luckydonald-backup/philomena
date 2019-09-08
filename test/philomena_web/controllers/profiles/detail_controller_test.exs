defmodule PhilomenaWeb.Profiles.DetailControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Profiles

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:detail) do
    {:ok, detail} = Profiles.create_detail(@create_attrs)
    detail
  end

  describe "index" do
    test "lists all details", %{conn: conn} do
      conn = get(conn, Routes.profiles_detail_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Details"
    end
  end

  describe "new detail" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.profiles_detail_path(conn, :new))
      assert html_response(conn, 200) =~ "New Detail"
    end
  end

  describe "create detail" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.profiles_detail_path(conn, :create), detail: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.profiles_detail_path(conn, :show, id)

      conn = get(conn, Routes.profiles_detail_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Detail"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.profiles_detail_path(conn, :create), detail: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Detail"
    end
  end

  describe "edit detail" do
    setup [:create_detail]

    test "renders form for editing chosen detail", %{conn: conn, detail: detail} do
      conn = get(conn, Routes.profiles_detail_path(conn, :edit, detail))
      assert html_response(conn, 200) =~ "Edit Detail"
    end
  end

  describe "update detail" do
    setup [:create_detail]

    test "redirects when data is valid", %{conn: conn, detail: detail} do
      conn = put(conn, Routes.profiles_detail_path(conn, :update, detail), detail: @update_attrs)
      assert redirected_to(conn) == Routes.profiles_detail_path(conn, :show, detail)

      conn = get(conn, Routes.profiles_detail_path(conn, :show, detail))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, detail: detail} do
      conn = put(conn, Routes.profiles_detail_path(conn, :update, detail), detail: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Detail"
    end
  end

  describe "delete detail" do
    setup [:create_detail]

    test "deletes chosen detail", %{conn: conn, detail: detail} do
      conn = delete(conn, Routes.profiles_detail_path(conn, :delete, detail))
      assert redirected_to(conn) == Routes.profiles_detail_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.profiles_detail_path(conn, :show, detail))
      end
    end
  end

  defp create_detail(_) do
    detail = fixture(:detail)
    {:ok, detail: detail}
  end
end
