defmodule PhilomenaWeb.Search.SyntaxControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Search

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:syntax) do
    {:ok, syntax} = Search.create_syntax(@create_attrs)
    syntax
  end

  describe "index" do
    test "lists all syntax", %{conn: conn} do
      conn = get(conn, Routes.search_syntax_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Syntax"
    end
  end

  describe "new syntax" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.search_syntax_path(conn, :new))
      assert html_response(conn, 200) =~ "New Syntax"
    end
  end

  describe "create syntax" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.search_syntax_path(conn, :create), syntax: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.search_syntax_path(conn, :show, id)

      conn = get(conn, Routes.search_syntax_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Syntax"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.search_syntax_path(conn, :create), syntax: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Syntax"
    end
  end

  describe "edit syntax" do
    setup [:create_syntax]

    test "renders form for editing chosen syntax", %{conn: conn, syntax: syntax} do
      conn = get(conn, Routes.search_syntax_path(conn, :edit, syntax))
      assert html_response(conn, 200) =~ "Edit Syntax"
    end
  end

  describe "update syntax" do
    setup [:create_syntax]

    test "redirects when data is valid", %{conn: conn, syntax: syntax} do
      conn = put(conn, Routes.search_syntax_path(conn, :update, syntax), syntax: @update_attrs)
      assert redirected_to(conn) == Routes.search_syntax_path(conn, :show, syntax)

      conn = get(conn, Routes.search_syntax_path(conn, :show, syntax))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, syntax: syntax} do
      conn = put(conn, Routes.search_syntax_path(conn, :update, syntax), syntax: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Syntax"
    end
  end

  describe "delete syntax" do
    setup [:create_syntax]

    test "deletes chosen syntax", %{conn: conn, syntax: syntax} do
      conn = delete(conn, Routes.search_syntax_path(conn, :delete, syntax))
      assert redirected_to(conn) == Routes.search_syntax_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.search_syntax_path(conn, :show, syntax))
      end
    end
  end

  defp create_syntax(_) do
    syntax = fixture(:syntax)
    {:ok, syntax: syntax}
  end
end
