defmodule PhilomenaWeb.Admin.FingerprintControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Bans

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:fingerprint) do
    {:ok, fingerprint} = Bans.create_fingerprint(@create_attrs)
    fingerprint
  end

  describe "index" do
    test "lists all fingerprint_bans", %{conn: conn} do
      conn = get(conn, Routes.admin_fingerprint_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Fingerprint bans"
    end
  end

  describe "new fingerprint" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.admin_fingerprint_path(conn, :new))
      assert html_response(conn, 200) =~ "New Fingerprint"
    end
  end

  describe "create fingerprint" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.admin_fingerprint_path(conn, :create), fingerprint: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_fingerprint_path(conn, :show, id)

      conn = get(conn, Routes.admin_fingerprint_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Fingerprint"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admin_fingerprint_path(conn, :create), fingerprint: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Fingerprint"
    end
  end

  describe "edit fingerprint" do
    setup [:create_fingerprint]

    test "renders form for editing chosen fingerprint", %{conn: conn, fingerprint: fingerprint} do
      conn = get(conn, Routes.admin_fingerprint_path(conn, :edit, fingerprint))
      assert html_response(conn, 200) =~ "Edit Fingerprint"
    end
  end

  describe "update fingerprint" do
    setup [:create_fingerprint]

    test "redirects when data is valid", %{conn: conn, fingerprint: fingerprint} do
      conn = put(conn, Routes.admin_fingerprint_path(conn, :update, fingerprint), fingerprint: @update_attrs)
      assert redirected_to(conn) == Routes.admin_fingerprint_path(conn, :show, fingerprint)

      conn = get(conn, Routes.admin_fingerprint_path(conn, :show, fingerprint))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, fingerprint: fingerprint} do
      conn = put(conn, Routes.admin_fingerprint_path(conn, :update, fingerprint), fingerprint: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Fingerprint"
    end
  end

  describe "delete fingerprint" do
    setup [:create_fingerprint]

    test "deletes chosen fingerprint", %{conn: conn, fingerprint: fingerprint} do
      conn = delete(conn, Routes.admin_fingerprint_path(conn, :delete, fingerprint))
      assert redirected_to(conn) == Routes.admin_fingerprint_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.admin_fingerprint_path(conn, :show, fingerprint))
      end
    end
  end

  defp create_fingerprint(_) do
    fingerprint = fixture(:fingerprint)
    {:ok, fingerprint: fingerprint}
  end
end
