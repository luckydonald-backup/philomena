defmodule PhilomenaWeb.Images.PreviewControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Images

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:preview) do
    {:ok, preview} = Images.create_preview(@create_attrs)
    preview
  end

  describe "index" do
    test "lists all image_previews", %{conn: conn} do
      conn = get(conn, Routes.images_preview_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Image previews"
    end
  end

  describe "new preview" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.images_preview_path(conn, :new))
      assert html_response(conn, 200) =~ "New Preview"
    end
  end

  describe "create preview" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.images_preview_path(conn, :create), preview: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.images_preview_path(conn, :show, id)

      conn = get(conn, Routes.images_preview_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Preview"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.images_preview_path(conn, :create), preview: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Preview"
    end
  end

  describe "edit preview" do
    setup [:create_preview]

    test "renders form for editing chosen preview", %{conn: conn, preview: preview} do
      conn = get(conn, Routes.images_preview_path(conn, :edit, preview))
      assert html_response(conn, 200) =~ "Edit Preview"
    end
  end

  describe "update preview" do
    setup [:create_preview]

    test "redirects when data is valid", %{conn: conn, preview: preview} do
      conn = put(conn, Routes.images_preview_path(conn, :update, preview), preview: @update_attrs)
      assert redirected_to(conn) == Routes.images_preview_path(conn, :show, preview)

      conn = get(conn, Routes.images_preview_path(conn, :show, preview))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, preview: preview} do
      conn = put(conn, Routes.images_preview_path(conn, :update, preview), preview: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Preview"
    end
  end

  describe "delete preview" do
    setup [:create_preview]

    test "deletes chosen preview", %{conn: conn, preview: preview} do
      conn = delete(conn, Routes.images_preview_path(conn, :delete, preview))
      assert redirected_to(conn) == Routes.images_preview_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.images_preview_path(conn, :show, preview))
      end
    end
  end

  defp create_preview(_) do
    preview = fixture(:preview)
    {:ok, preview: preview}
  end
end
