defmodule PhilomenaWeb.Topics.LockControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Topics

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:lock) do
    {:ok, lock} = Topics.create_lock(@create_attrs)
    lock
  end

  describe "index" do
    test "lists all locks", %{conn: conn} do
      conn = get(conn, Routes.topics_lock_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Locks"
    end
  end

  describe "new lock" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.topics_lock_path(conn, :new))
      assert html_response(conn, 200) =~ "New Lock"
    end
  end

  describe "create lock" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.topics_lock_path(conn, :create), lock: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.topics_lock_path(conn, :show, id)

      conn = get(conn, Routes.topics_lock_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Lock"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.topics_lock_path(conn, :create), lock: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Lock"
    end
  end

  describe "edit lock" do
    setup [:create_lock]

    test "renders form for editing chosen lock", %{conn: conn, lock: lock} do
      conn = get(conn, Routes.topics_lock_path(conn, :edit, lock))
      assert html_response(conn, 200) =~ "Edit Lock"
    end
  end

  describe "update lock" do
    setup [:create_lock]

    test "redirects when data is valid", %{conn: conn, lock: lock} do
      conn = put(conn, Routes.topics_lock_path(conn, :update, lock), lock: @update_attrs)
      assert redirected_to(conn) == Routes.topics_lock_path(conn, :show, lock)

      conn = get(conn, Routes.topics_lock_path(conn, :show, lock))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, lock: lock} do
      conn = put(conn, Routes.topics_lock_path(conn, :update, lock), lock: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Lock"
    end
  end

  describe "delete lock" do
    setup [:create_lock]

    test "deletes chosen lock", %{conn: conn, lock: lock} do
      conn = delete(conn, Routes.topics_lock_path(conn, :delete, lock))
      assert redirected_to(conn) == Routes.topics_lock_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.topics_lock_path(conn, :show, lock))
      end
    end
  end

  defp create_lock(_) do
    lock = fixture(:lock)
    {:ok, lock: lock}
  end
end
