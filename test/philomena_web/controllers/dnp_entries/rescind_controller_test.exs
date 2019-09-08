defmodule PhilomenaWeb.DnpEntries.RescindControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.DnpEntries

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:rescind) do
    {:ok, rescind} = DnpEntries.create_rescind(@create_attrs)
    rescind
  end

  describe "index" do
    test "lists all rescinds", %{conn: conn} do
      conn = get(conn, Routes.dnp_entries_rescind_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Rescinds"
    end
  end

  describe "new rescind" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.dnp_entries_rescind_path(conn, :new))
      assert html_response(conn, 200) =~ "New Rescind"
    end
  end

  describe "create rescind" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.dnp_entries_rescind_path(conn, :create), rescind: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.dnp_entries_rescind_path(conn, :show, id)

      conn = get(conn, Routes.dnp_entries_rescind_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Rescind"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.dnp_entries_rescind_path(conn, :create), rescind: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Rescind"
    end
  end

  describe "edit rescind" do
    setup [:create_rescind]

    test "renders form for editing chosen rescind", %{conn: conn, rescind: rescind} do
      conn = get(conn, Routes.dnp_entries_rescind_path(conn, :edit, rescind))
      assert html_response(conn, 200) =~ "Edit Rescind"
    end
  end

  describe "update rescind" do
    setup [:create_rescind]

    test "redirects when data is valid", %{conn: conn, rescind: rescind} do
      conn = put(conn, Routes.dnp_entries_rescind_path(conn, :update, rescind), rescind: @update_attrs)
      assert redirected_to(conn) == Routes.dnp_entries_rescind_path(conn, :show, rescind)

      conn = get(conn, Routes.dnp_entries_rescind_path(conn, :show, rescind))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, rescind: rescind} do
      conn = put(conn, Routes.dnp_entries_rescind_path(conn, :update, rescind), rescind: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Rescind"
    end
  end

  describe "delete rescind" do
    setup [:create_rescind]

    test "deletes chosen rescind", %{conn: conn, rescind: rescind} do
      conn = delete(conn, Routes.dnp_entries_rescind_path(conn, :delete, rescind))
      assert redirected_to(conn) == Routes.dnp_entries_rescind_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.dnp_entries_rescind_path(conn, :show, rescind))
      end
    end
  end

  defp create_rescind(_) do
    rescind = fixture(:rescind)
    {:ok, rescind: rescind}
  end
end
