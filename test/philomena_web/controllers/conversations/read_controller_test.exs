defmodule PhilomenaWeb.Conversations.ReadControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Conversations

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:read) do
    {:ok, read} = Conversations.create_read(@create_attrs)
    read
  end

  describe "index" do
    test "lists all read", %{conn: conn} do
      conn = get(conn, Routes.conversations_read_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Read"
    end
  end

  describe "new read" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.conversations_read_path(conn, :new))
      assert html_response(conn, 200) =~ "New Read"
    end
  end

  describe "create read" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.conversations_read_path(conn, :create), read: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.conversations_read_path(conn, :show, id)

      conn = get(conn, Routes.conversations_read_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Read"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.conversations_read_path(conn, :create), read: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Read"
    end
  end

  describe "edit read" do
    setup [:create_read]

    test "renders form for editing chosen read", %{conn: conn, read: read} do
      conn = get(conn, Routes.conversations_read_path(conn, :edit, read))
      assert html_response(conn, 200) =~ "Edit Read"
    end
  end

  describe "update read" do
    setup [:create_read]

    test "redirects when data is valid", %{conn: conn, read: read} do
      conn = put(conn, Routes.conversations_read_path(conn, :update, read), read: @update_attrs)
      assert redirected_to(conn) == Routes.conversations_read_path(conn, :show, read)

      conn = get(conn, Routes.conversations_read_path(conn, :show, read))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, read: read} do
      conn = put(conn, Routes.conversations_read_path(conn, :update, read), read: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Read"
    end
  end

  describe "delete read" do
    setup [:create_read]

    test "deletes chosen read", %{conn: conn, read: read} do
      conn = delete(conn, Routes.conversations_read_path(conn, :delete, read))
      assert redirected_to(conn) == Routes.conversations_read_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.conversations_read_path(conn, :show, read))
      end
    end
  end

  defp create_read(_) do
    read = fixture(:read)
    {:ok, read: read}
  end
end
