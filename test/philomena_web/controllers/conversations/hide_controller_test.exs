defmodule PhilomenaWeb.Conversations.HideControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Conversations

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:hide) do
    {:ok, hide} = Conversations.create_hide(@create_attrs)
    hide
  end

  describe "index" do
    test "lists all hide", %{conn: conn} do
      conn = get(conn, Routes.conversations_hide_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Hide"
    end
  end

  describe "new hide" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.conversations_hide_path(conn, :new))
      assert html_response(conn, 200) =~ "New Hide"
    end
  end

  describe "create hide" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.conversations_hide_path(conn, :create), hide: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.conversations_hide_path(conn, :show, id)

      conn = get(conn, Routes.conversations_hide_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Hide"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.conversations_hide_path(conn, :create), hide: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Hide"
    end
  end

  describe "edit hide" do
    setup [:create_hide]

    test "renders form for editing chosen hide", %{conn: conn, hide: hide} do
      conn = get(conn, Routes.conversations_hide_path(conn, :edit, hide))
      assert html_response(conn, 200) =~ "Edit Hide"
    end
  end

  describe "update hide" do
    setup [:create_hide]

    test "redirects when data is valid", %{conn: conn, hide: hide} do
      conn = put(conn, Routes.conversations_hide_path(conn, :update, hide), hide: @update_attrs)
      assert redirected_to(conn) == Routes.conversations_hide_path(conn, :show, hide)

      conn = get(conn, Routes.conversations_hide_path(conn, :show, hide))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, hide: hide} do
      conn = put(conn, Routes.conversations_hide_path(conn, :update, hide), hide: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Hide"
    end
  end

  describe "delete hide" do
    setup [:create_hide]

    test "deletes chosen hide", %{conn: conn, hide: hide} do
      conn = delete(conn, Routes.conversations_hide_path(conn, :delete, hide))
      assert redirected_to(conn) == Routes.conversations_hide_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.conversations_hide_path(conn, :show, hide))
      end
    end
  end

  defp create_hide(_) do
    hide = fixture(:hide)
    {:ok, hide: hide}
  end
end
