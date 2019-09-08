defmodule PhilomenaWeb.Conversations.HideBatchControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Conversations

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:hide_batch) do
    {:ok, hide_batch} = Conversations.create_hide_batch(@create_attrs)
    hide_batch
  end

  describe "index" do
    test "lists all hide_batch", %{conn: conn} do
      conn = get(conn, Routes.conversations_hide_batch_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Hide batch"
    end
  end

  describe "new hide_batch" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.conversations_hide_batch_path(conn, :new))
      assert html_response(conn, 200) =~ "New Hide batch"
    end
  end

  describe "create hide_batch" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.conversations_hide_batch_path(conn, :create), hide_batch: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.conversations_hide_batch_path(conn, :show, id)

      conn = get(conn, Routes.conversations_hide_batch_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Hide batch"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.conversations_hide_batch_path(conn, :create), hide_batch: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Hide batch"
    end
  end

  describe "edit hide_batch" do
    setup [:create_hide_batch]

    test "renders form for editing chosen hide_batch", %{conn: conn, hide_batch: hide_batch} do
      conn = get(conn, Routes.conversations_hide_batch_path(conn, :edit, hide_batch))
      assert html_response(conn, 200) =~ "Edit Hide batch"
    end
  end

  describe "update hide_batch" do
    setup [:create_hide_batch]

    test "redirects when data is valid", %{conn: conn, hide_batch: hide_batch} do
      conn = put(conn, Routes.conversations_hide_batch_path(conn, :update, hide_batch), hide_batch: @update_attrs)
      assert redirected_to(conn) == Routes.conversations_hide_batch_path(conn, :show, hide_batch)

      conn = get(conn, Routes.conversations_hide_batch_path(conn, :show, hide_batch))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, hide_batch: hide_batch} do
      conn = put(conn, Routes.conversations_hide_batch_path(conn, :update, hide_batch), hide_batch: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Hide batch"
    end
  end

  describe "delete hide_batch" do
    setup [:create_hide_batch]

    test "deletes chosen hide_batch", %{conn: conn, hide_batch: hide_batch} do
      conn = delete(conn, Routes.conversations_hide_batch_path(conn, :delete, hide_batch))
      assert redirected_to(conn) == Routes.conversations_hide_batch_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.conversations_hide_batch_path(conn, :show, hide_batch))
      end
    end
  end

  defp create_hide_batch(_) do
    hide_batch = fixture(:hide_batch)
    {:ok, hide_batch: hide_batch}
  end
end
