defmodule PhilomenaWeb.Topics.Posts.HistoryControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Topics

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:history) do
    {:ok, history} = Topics.create_history(@create_attrs)
    history
  end

  describe "index" do
    test "lists all histories", %{conn: conn} do
      conn = get(conn, Routes.topics_posts_history_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Histories"
    end
  end

  describe "new history" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.topics_posts_history_path(conn, :new))
      assert html_response(conn, 200) =~ "New History"
    end
  end

  describe "create history" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.topics_posts_history_path(conn, :create), history: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.topics_posts_history_path(conn, :show, id)

      conn = get(conn, Routes.topics_posts_history_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show History"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.topics_posts_history_path(conn, :create), history: @invalid_attrs)
      assert html_response(conn, 200) =~ "New History"
    end
  end

  describe "edit history" do
    setup [:create_history]

    test "renders form for editing chosen history", %{conn: conn, history: history} do
      conn = get(conn, Routes.topics_posts_history_path(conn, :edit, history))
      assert html_response(conn, 200) =~ "Edit History"
    end
  end

  describe "update history" do
    setup [:create_history]

    test "redirects when data is valid", %{conn: conn, history: history} do
      conn = put(conn, Routes.topics_posts_history_path(conn, :update, history), history: @update_attrs)
      assert redirected_to(conn) == Routes.topics_posts_history_path(conn, :show, history)

      conn = get(conn, Routes.topics_posts_history_path(conn, :show, history))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, history: history} do
      conn = put(conn, Routes.topics_posts_history_path(conn, :update, history), history: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit History"
    end
  end

  describe "delete history" do
    setup [:create_history]

    test "deletes chosen history", %{conn: conn, history: history} do
      conn = delete(conn, Routes.topics_posts_history_path(conn, :delete, history))
      assert redirected_to(conn) == Routes.topics_posts_history_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.topics_posts_history_path(conn, :show, history))
      end
    end
  end

  defp create_history(_) do
    history = fixture(:history)
    {:ok, history: history}
  end
end
