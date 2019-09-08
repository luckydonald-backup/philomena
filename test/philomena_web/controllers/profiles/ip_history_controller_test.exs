defmodule PhilomenaWeb.Profiles.IpHistoryControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Profiles

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:ip_history) do
    {:ok, ip_history} = Profiles.create_ip_history(@create_attrs)
    ip_history
  end

  describe "index" do
    test "lists all ip_histories", %{conn: conn} do
      conn = get(conn, Routes.profiles_ip_history_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Ip histories"
    end
  end

  describe "new ip_history" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.profiles_ip_history_path(conn, :new))
      assert html_response(conn, 200) =~ "New Ip history"
    end
  end

  describe "create ip_history" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.profiles_ip_history_path(conn, :create), ip_history: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.profiles_ip_history_path(conn, :show, id)

      conn = get(conn, Routes.profiles_ip_history_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Ip history"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.profiles_ip_history_path(conn, :create), ip_history: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Ip history"
    end
  end

  describe "edit ip_history" do
    setup [:create_ip_history]

    test "renders form for editing chosen ip_history", %{conn: conn, ip_history: ip_history} do
      conn = get(conn, Routes.profiles_ip_history_path(conn, :edit, ip_history))
      assert html_response(conn, 200) =~ "Edit Ip history"
    end
  end

  describe "update ip_history" do
    setup [:create_ip_history]

    test "redirects when data is valid", %{conn: conn, ip_history: ip_history} do
      conn = put(conn, Routes.profiles_ip_history_path(conn, :update, ip_history), ip_history: @update_attrs)
      assert redirected_to(conn) == Routes.profiles_ip_history_path(conn, :show, ip_history)

      conn = get(conn, Routes.profiles_ip_history_path(conn, :show, ip_history))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, ip_history: ip_history} do
      conn = put(conn, Routes.profiles_ip_history_path(conn, :update, ip_history), ip_history: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Ip history"
    end
  end

  describe "delete ip_history" do
    setup [:create_ip_history]

    test "deletes chosen ip_history", %{conn: conn, ip_history: ip_history} do
      conn = delete(conn, Routes.profiles_ip_history_path(conn, :delete, ip_history))
      assert redirected_to(conn) == Routes.profiles_ip_history_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.profiles_ip_history_path(conn, :show, ip_history))
      end
    end
  end

  defp create_ip_history(_) do
    ip_history = fixture(:ip_history)
    {:ok, ip_history: ip_history}
  end
end
