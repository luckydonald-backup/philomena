defmodule PhilomenaWeb.Images.RelatedControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Images

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:related) do
    {:ok, related} = Images.create_related(@create_attrs)
    related
  end

  describe "index" do
    test "lists all relateds", %{conn: conn} do
      conn = get(conn, Routes.images_related_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Relateds"
    end
  end

  describe "new related" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.images_related_path(conn, :new))
      assert html_response(conn, 200) =~ "New Related"
    end
  end

  describe "create related" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.images_related_path(conn, :create), related: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.images_related_path(conn, :show, id)

      conn = get(conn, Routes.images_related_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Related"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.images_related_path(conn, :create), related: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Related"
    end
  end

  describe "edit related" do
    setup [:create_related]

    test "renders form for editing chosen related", %{conn: conn, related: related} do
      conn = get(conn, Routes.images_related_path(conn, :edit, related))
      assert html_response(conn, 200) =~ "Edit Related"
    end
  end

  describe "update related" do
    setup [:create_related]

    test "redirects when data is valid", %{conn: conn, related: related} do
      conn = put(conn, Routes.images_related_path(conn, :update, related), related: @update_attrs)
      assert redirected_to(conn) == Routes.images_related_path(conn, :show, related)

      conn = get(conn, Routes.images_related_path(conn, :show, related))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, related: related} do
      conn = put(conn, Routes.images_related_path(conn, :update, related), related: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Related"
    end
  end

  describe "delete related" do
    setup [:create_related]

    test "deletes chosen related", %{conn: conn, related: related} do
      conn = delete(conn, Routes.images_related_path(conn, :delete, related))
      assert redirected_to(conn) == Routes.images_related_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.images_related_path(conn, :show, related))
      end
    end
  end

  defp create_related(_) do
    related = fixture(:related)
    {:ok, related: related}
  end
end
