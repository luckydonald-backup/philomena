defmodule PhilomenaWeb.Admin.AdvertControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Adverts

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:advert) do
    {:ok, advert} = Adverts.create_advert(@create_attrs)
    advert
  end

  describe "index" do
    test "lists all adverts", %{conn: conn} do
      conn = get(conn, Routes.admin_advert_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Adverts"
    end
  end

  describe "new advert" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.admin_advert_path(conn, :new))
      assert html_response(conn, 200) =~ "New Advert"
    end
  end

  describe "create advert" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.admin_advert_path(conn, :create), advert: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_advert_path(conn, :show, id)

      conn = get(conn, Routes.admin_advert_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Advert"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admin_advert_path(conn, :create), advert: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Advert"
    end
  end

  describe "edit advert" do
    setup [:create_advert]

    test "renders form for editing chosen advert", %{conn: conn, advert: advert} do
      conn = get(conn, Routes.admin_advert_path(conn, :edit, advert))
      assert html_response(conn, 200) =~ "Edit Advert"
    end
  end

  describe "update advert" do
    setup [:create_advert]

    test "redirects when data is valid", %{conn: conn, advert: advert} do
      conn = put(conn, Routes.admin_advert_path(conn, :update, advert), advert: @update_attrs)
      assert redirected_to(conn) == Routes.admin_advert_path(conn, :show, advert)

      conn = get(conn, Routes.admin_advert_path(conn, :show, advert))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, advert: advert} do
      conn = put(conn, Routes.admin_advert_path(conn, :update, advert), advert: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Advert"
    end
  end

  describe "delete advert" do
    setup [:create_advert]

    test "deletes chosen advert", %{conn: conn, advert: advert} do
      conn = delete(conn, Routes.admin_advert_path(conn, :delete, advert))
      assert redirected_to(conn) == Routes.admin_advert_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.admin_advert_path(conn, :show, advert))
      end
    end
  end

  defp create_advert(_) do
    advert = fixture(:advert)
    {:ok, advert: advert}
  end
end
