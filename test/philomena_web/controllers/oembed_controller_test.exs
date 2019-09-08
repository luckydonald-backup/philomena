defmodule PhilomenaWeb.OembedControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Oembeds

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:oembed) do
    {:ok, oembed} = Oembeds.create_oembed(@create_attrs)
    oembed
  end

  describe "index" do
    test "lists all oembeds", %{conn: conn} do
      conn = get(conn, Routes.oembed_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Oembeds"
    end
  end

  describe "new oembed" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.oembed_path(conn, :new))
      assert html_response(conn, 200) =~ "New Oembed"
    end
  end

  describe "create oembed" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.oembed_path(conn, :create), oembed: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.oembed_path(conn, :show, id)

      conn = get(conn, Routes.oembed_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Oembed"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.oembed_path(conn, :create), oembed: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Oembed"
    end
  end

  describe "edit oembed" do
    setup [:create_oembed]

    test "renders form for editing chosen oembed", %{conn: conn, oembed: oembed} do
      conn = get(conn, Routes.oembed_path(conn, :edit, oembed))
      assert html_response(conn, 200) =~ "Edit Oembed"
    end
  end

  describe "update oembed" do
    setup [:create_oembed]

    test "redirects when data is valid", %{conn: conn, oembed: oembed} do
      conn = put(conn, Routes.oembed_path(conn, :update, oembed), oembed: @update_attrs)
      assert redirected_to(conn) == Routes.oembed_path(conn, :show, oembed)

      conn = get(conn, Routes.oembed_path(conn, :show, oembed))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, oembed: oembed} do
      conn = put(conn, Routes.oembed_path(conn, :update, oembed), oembed: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Oembed"
    end
  end

  describe "delete oembed" do
    setup [:create_oembed]

    test "deletes chosen oembed", %{conn: conn, oembed: oembed} do
      conn = delete(conn, Routes.oembed_path(conn, :delete, oembed))
      assert redirected_to(conn) == Routes.oembed_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.oembed_path(conn, :show, oembed))
      end
    end
  end

  defp create_oembed(_) do
    oembed = fixture(:oembed)
    {:ok, oembed: oembed}
  end
end
