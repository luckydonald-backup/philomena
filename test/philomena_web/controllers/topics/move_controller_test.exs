defmodule PhilomenaWeb.Topics.MoveControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Topics

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:move) do
    {:ok, move} = Topics.create_move(@create_attrs)
    move
  end

  describe "index" do
    test "lists all moves", %{conn: conn} do
      conn = get(conn, Routes.topics_move_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Moves"
    end
  end

  describe "new move" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.topics_move_path(conn, :new))
      assert html_response(conn, 200) =~ "New Move"
    end
  end

  describe "create move" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.topics_move_path(conn, :create), move: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.topics_move_path(conn, :show, id)

      conn = get(conn, Routes.topics_move_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Move"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.topics_move_path(conn, :create), move: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Move"
    end
  end

  describe "edit move" do
    setup [:create_move]

    test "renders form for editing chosen move", %{conn: conn, move: move} do
      conn = get(conn, Routes.topics_move_path(conn, :edit, move))
      assert html_response(conn, 200) =~ "Edit Move"
    end
  end

  describe "update move" do
    setup [:create_move]

    test "redirects when data is valid", %{conn: conn, move: move} do
      conn = put(conn, Routes.topics_move_path(conn, :update, move), move: @update_attrs)
      assert redirected_to(conn) == Routes.topics_move_path(conn, :show, move)

      conn = get(conn, Routes.topics_move_path(conn, :show, move))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, move: move} do
      conn = put(conn, Routes.topics_move_path(conn, :update, move), move: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Move"
    end
  end

  describe "delete move" do
    setup [:create_move]

    test "deletes chosen move", %{conn: conn, move: move} do
      conn = delete(conn, Routes.topics_move_path(conn, :delete, move))
      assert redirected_to(conn) == Routes.topics_move_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.topics_move_path(conn, :show, move))
      end
    end
  end

  defp create_move(_) do
    move = fixture(:move)
    {:ok, move: move}
  end
end
