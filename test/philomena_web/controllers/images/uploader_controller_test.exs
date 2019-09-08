defmodule PhilomenaWeb.Images.UploaderControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Images

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:uploader) do
    {:ok, uploader} = Images.create_uploader(@create_attrs)
    uploader
  end

  describe "index" do
    test "lists all uploader", %{conn: conn} do
      conn = get(conn, Routes.images_uploader_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Uploader"
    end
  end

  describe "new uploader" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.images_uploader_path(conn, :new))
      assert html_response(conn, 200) =~ "New Uploader"
    end
  end

  describe "create uploader" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.images_uploader_path(conn, :create), uploader: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.images_uploader_path(conn, :show, id)

      conn = get(conn, Routes.images_uploader_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Uploader"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.images_uploader_path(conn, :create), uploader: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Uploader"
    end
  end

  describe "edit uploader" do
    setup [:create_uploader]

    test "renders form for editing chosen uploader", %{conn: conn, uploader: uploader} do
      conn = get(conn, Routes.images_uploader_path(conn, :edit, uploader))
      assert html_response(conn, 200) =~ "Edit Uploader"
    end
  end

  describe "update uploader" do
    setup [:create_uploader]

    test "redirects when data is valid", %{conn: conn, uploader: uploader} do
      conn = put(conn, Routes.images_uploader_path(conn, :update, uploader), uploader: @update_attrs)
      assert redirected_to(conn) == Routes.images_uploader_path(conn, :show, uploader)

      conn = get(conn, Routes.images_uploader_path(conn, :show, uploader))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, uploader: uploader} do
      conn = put(conn, Routes.images_uploader_path(conn, :update, uploader), uploader: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Uploader"
    end
  end

  describe "delete uploader" do
    setup [:create_uploader]

    test "deletes chosen uploader", %{conn: conn, uploader: uploader} do
      conn = delete(conn, Routes.images_uploader_path(conn, :delete, uploader))
      assert redirected_to(conn) == Routes.images_uploader_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.images_uploader_path(conn, :show, uploader))
      end
    end
  end

  defp create_uploader(_) do
    uploader = fixture(:uploader)
    {:ok, uploader: uploader}
  end
end
