defmodule PhilomenaWeb.FingerprintProfileControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.FingerprintProfiles

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:fingerprint_profile) do
    {:ok, fingerprint_profile} = FingerprintProfiles.create_fingerprint_profile(@create_attrs)
    fingerprint_profile
  end

  describe "index" do
    test "lists all fingerprint_profiles", %{conn: conn} do
      conn = get(conn, Routes.fingerprint_profile_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Fingerprint profiles"
    end
  end

  describe "new fingerprint_profile" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.fingerprint_profile_path(conn, :new))
      assert html_response(conn, 200) =~ "New Fingerprint profile"
    end
  end

  describe "create fingerprint_profile" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.fingerprint_profile_path(conn, :create), fingerprint_profile: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.fingerprint_profile_path(conn, :show, id)

      conn = get(conn, Routes.fingerprint_profile_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Fingerprint profile"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.fingerprint_profile_path(conn, :create), fingerprint_profile: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Fingerprint profile"
    end
  end

  describe "edit fingerprint_profile" do
    setup [:create_fingerprint_profile]

    test "renders form for editing chosen fingerprint_profile", %{conn: conn, fingerprint_profile: fingerprint_profile} do
      conn = get(conn, Routes.fingerprint_profile_path(conn, :edit, fingerprint_profile))
      assert html_response(conn, 200) =~ "Edit Fingerprint profile"
    end
  end

  describe "update fingerprint_profile" do
    setup [:create_fingerprint_profile]

    test "redirects when data is valid", %{conn: conn, fingerprint_profile: fingerprint_profile} do
      conn = put(conn, Routes.fingerprint_profile_path(conn, :update, fingerprint_profile), fingerprint_profile: @update_attrs)
      assert redirected_to(conn) == Routes.fingerprint_profile_path(conn, :show, fingerprint_profile)

      conn = get(conn, Routes.fingerprint_profile_path(conn, :show, fingerprint_profile))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, fingerprint_profile: fingerprint_profile} do
      conn = put(conn, Routes.fingerprint_profile_path(conn, :update, fingerprint_profile), fingerprint_profile: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Fingerprint profile"
    end
  end

  describe "delete fingerprint_profile" do
    setup [:create_fingerprint_profile]

    test "deletes chosen fingerprint_profile", %{conn: conn, fingerprint_profile: fingerprint_profile} do
      conn = delete(conn, Routes.fingerprint_profile_path(conn, :delete, fingerprint_profile))
      assert redirected_to(conn) == Routes.fingerprint_profile_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.fingerprint_profile_path(conn, :show, fingerprint_profile))
      end
    end
  end

  defp create_fingerprint_profile(_) do
    fingerprint_profile = fixture(:fingerprint_profile)
    {:ok, fingerprint_profile: fingerprint_profile}
  end
end
