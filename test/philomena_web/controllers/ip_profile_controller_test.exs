defmodule PhilomenaWeb.IpProfileControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.IpProfiles

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:ip_profile) do
    {:ok, ip_profile} = IpProfiles.create_ip_profile(@create_attrs)
    ip_profile
  end

  describe "index" do
    test "lists all ip_profiles", %{conn: conn} do
      conn = get(conn, Routes.ip_profile_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Ip profiles"
    end
  end

  describe "new ip_profile" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.ip_profile_path(conn, :new))
      assert html_response(conn, 200) =~ "New Ip profile"
    end
  end

  describe "create ip_profile" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.ip_profile_path(conn, :create), ip_profile: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.ip_profile_path(conn, :show, id)

      conn = get(conn, Routes.ip_profile_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Ip profile"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.ip_profile_path(conn, :create), ip_profile: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Ip profile"
    end
  end

  describe "edit ip_profile" do
    setup [:create_ip_profile]

    test "renders form for editing chosen ip_profile", %{conn: conn, ip_profile: ip_profile} do
      conn = get(conn, Routes.ip_profile_path(conn, :edit, ip_profile))
      assert html_response(conn, 200) =~ "Edit Ip profile"
    end
  end

  describe "update ip_profile" do
    setup [:create_ip_profile]

    test "redirects when data is valid", %{conn: conn, ip_profile: ip_profile} do
      conn = put(conn, Routes.ip_profile_path(conn, :update, ip_profile), ip_profile: @update_attrs)
      assert redirected_to(conn) == Routes.ip_profile_path(conn, :show, ip_profile)

      conn = get(conn, Routes.ip_profile_path(conn, :show, ip_profile))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, ip_profile: ip_profile} do
      conn = put(conn, Routes.ip_profile_path(conn, :update, ip_profile), ip_profile: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Ip profile"
    end
  end

  describe "delete ip_profile" do
    setup [:create_ip_profile]

    test "deletes chosen ip_profile", %{conn: conn, ip_profile: ip_profile} do
      conn = delete(conn, Routes.ip_profile_path(conn, :delete, ip_profile))
      assert redirected_to(conn) == Routes.ip_profile_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.ip_profile_path(conn, :show, ip_profile))
      end
    end
  end

  defp create_ip_profile(_) do
    ip_profile = fixture(:ip_profile)
    {:ok, ip_profile: ip_profile}
  end
end
