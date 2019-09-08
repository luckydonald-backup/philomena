defmodule PhilomenaWeb.Images.SourceHistoryControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Images

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:source_history) do
    {:ok, source_history} = Images.create_source_history(@create_attrs)
    source_history
  end

  describe "index" do
    test "lists all source_histories", %{conn: conn} do
      conn = get(conn, Routes.images_source_history_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Source histories"
    end
  end

  describe "new source_history" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.images_source_history_path(conn, :new))
      assert html_response(conn, 200) =~ "New Source history"
    end
  end

  describe "create source_history" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.images_source_history_path(conn, :create), source_history: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.images_source_history_path(conn, :show, id)

      conn = get(conn, Routes.images_source_history_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Source history"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.images_source_history_path(conn, :create), source_history: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Source history"
    end
  end

  describe "edit source_history" do
    setup [:create_source_history]

    test "renders form for editing chosen source_history", %{conn: conn, source_history: source_history} do
      conn = get(conn, Routes.images_source_history_path(conn, :edit, source_history))
      assert html_response(conn, 200) =~ "Edit Source history"
    end
  end

  describe "update source_history" do
    setup [:create_source_history]

    test "redirects when data is valid", %{conn: conn, source_history: source_history} do
      conn = put(conn, Routes.images_source_history_path(conn, :update, source_history), source_history: @update_attrs)
      assert redirected_to(conn) == Routes.images_source_history_path(conn, :show, source_history)

      conn = get(conn, Routes.images_source_history_path(conn, :show, source_history))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, source_history: source_history} do
      conn = put(conn, Routes.images_source_history_path(conn, :update, source_history), source_history: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Source history"
    end
  end

  describe "delete source_history" do
    setup [:create_source_history]

    test "deletes chosen source_history", %{conn: conn, source_history: source_history} do
      conn = delete(conn, Routes.images_source_history_path(conn, :delete, source_history))
      assert redirected_to(conn) == Routes.images_source_history_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.images_source_history_path(conn, :show, source_history))
      end
    end
  end

  defp create_source_history(_) do
    source_history = fixture(:source_history)
    {:ok, source_history: source_history}
  end
end
