defmodule PhilomenaWeb.Search.ReverseControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Search

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:reverse) do
    {:ok, reverse} = Search.create_reverse(@create_attrs)
    reverse
  end

  describe "index" do
    test "lists all reverse", %{conn: conn} do
      conn = get(conn, Routes.search_reverse_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Reverse"
    end
  end

  describe "new reverse" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.search_reverse_path(conn, :new))
      assert html_response(conn, 200) =~ "New Reverse"
    end
  end

  describe "create reverse" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.search_reverse_path(conn, :create), reverse: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.search_reverse_path(conn, :show, id)

      conn = get(conn, Routes.search_reverse_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Reverse"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.search_reverse_path(conn, :create), reverse: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Reverse"
    end
  end

  describe "edit reverse" do
    setup [:create_reverse]

    test "renders form for editing chosen reverse", %{conn: conn, reverse: reverse} do
      conn = get(conn, Routes.search_reverse_path(conn, :edit, reverse))
      assert html_response(conn, 200) =~ "Edit Reverse"
    end
  end

  describe "update reverse" do
    setup [:create_reverse]

    test "redirects when data is valid", %{conn: conn, reverse: reverse} do
      conn = put(conn, Routes.search_reverse_path(conn, :update, reverse), reverse: @update_attrs)
      assert redirected_to(conn) == Routes.search_reverse_path(conn, :show, reverse)

      conn = get(conn, Routes.search_reverse_path(conn, :show, reverse))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, reverse: reverse} do
      conn = put(conn, Routes.search_reverse_path(conn, :update, reverse), reverse: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Reverse"
    end
  end

  describe "delete reverse" do
    setup [:create_reverse]

    test "deletes chosen reverse", %{conn: conn, reverse: reverse} do
      conn = delete(conn, Routes.search_reverse_path(conn, :delete, reverse))
      assert redirected_to(conn) == Routes.search_reverse_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.search_reverse_path(conn, :show, reverse))
      end
    end
  end

  defp create_reverse(_) do
    reverse = fixture(:reverse)
    {:ok, reverse: reverse}
  end
end
