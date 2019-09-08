defmodule PhilomenaWeb.Admin.Tags.ReindexControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Tags

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:reindex) do
    {:ok, reindex} = Tags.create_reindex(@create_attrs)
    reindex
  end

  describe "index" do
    test "lists all tags", %{conn: conn} do
      conn = get(conn, Routes.admin_tags_reindex_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Tags"
    end
  end

  describe "new reindex" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.admin_tags_reindex_path(conn, :new))
      assert html_response(conn, 200) =~ "New Reindex"
    end
  end

  describe "create reindex" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.admin_tags_reindex_path(conn, :create), reindex: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_tags_reindex_path(conn, :show, id)

      conn = get(conn, Routes.admin_tags_reindex_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Reindex"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admin_tags_reindex_path(conn, :create), reindex: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Reindex"
    end
  end

  describe "edit reindex" do
    setup [:create_reindex]

    test "renders form for editing chosen reindex", %{conn: conn, reindex: reindex} do
      conn = get(conn, Routes.admin_tags_reindex_path(conn, :edit, reindex))
      assert html_response(conn, 200) =~ "Edit Reindex"
    end
  end

  describe "update reindex" do
    setup [:create_reindex]

    test "redirects when data is valid", %{conn: conn, reindex: reindex} do
      conn = put(conn, Routes.admin_tags_reindex_path(conn, :update, reindex), reindex: @update_attrs)
      assert redirected_to(conn) == Routes.admin_tags_reindex_path(conn, :show, reindex)

      conn = get(conn, Routes.admin_tags_reindex_path(conn, :show, reindex))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, reindex: reindex} do
      conn = put(conn, Routes.admin_tags_reindex_path(conn, :update, reindex), reindex: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Reindex"
    end
  end

  describe "delete reindex" do
    setup [:create_reindex]

    test "deletes chosen reindex", %{conn: conn, reindex: reindex} do
      conn = delete(conn, Routes.admin_tags_reindex_path(conn, :delete, reindex))
      assert redirected_to(conn) == Routes.admin_tags_reindex_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.admin_tags_reindex_path(conn, :show, reindex))
      end
    end
  end

  defp create_reindex(_) do
    reindex = fixture(:reindex)
    {:ok, reindex: reindex}
  end
end
