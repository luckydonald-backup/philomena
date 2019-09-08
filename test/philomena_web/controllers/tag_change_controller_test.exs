defmodule PhilomenaWeb.TagChangeControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.TagChanges

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:tag_change) do
    {:ok, tag_change} = TagChanges.create_tag_change(@create_attrs)
    tag_change
  end

  describe "index" do
    test "lists all tag_changes", %{conn: conn} do
      conn = get(conn, Routes.tag_change_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Tag changes"
    end
  end

  describe "new tag_change" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.tag_change_path(conn, :new))
      assert html_response(conn, 200) =~ "New Tag change"
    end
  end

  describe "create tag_change" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.tag_change_path(conn, :create), tag_change: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.tag_change_path(conn, :show, id)

      conn = get(conn, Routes.tag_change_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Tag change"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.tag_change_path(conn, :create), tag_change: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Tag change"
    end
  end

  describe "edit tag_change" do
    setup [:create_tag_change]

    test "renders form for editing chosen tag_change", %{conn: conn, tag_change: tag_change} do
      conn = get(conn, Routes.tag_change_path(conn, :edit, tag_change))
      assert html_response(conn, 200) =~ "Edit Tag change"
    end
  end

  describe "update tag_change" do
    setup [:create_tag_change]

    test "redirects when data is valid", %{conn: conn, tag_change: tag_change} do
      conn = put(conn, Routes.tag_change_path(conn, :update, tag_change), tag_change: @update_attrs)
      assert redirected_to(conn) == Routes.tag_change_path(conn, :show, tag_change)

      conn = get(conn, Routes.tag_change_path(conn, :show, tag_change))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, tag_change: tag_change} do
      conn = put(conn, Routes.tag_change_path(conn, :update, tag_change), tag_change: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Tag change"
    end
  end

  describe "delete tag_change" do
    setup [:create_tag_change]

    test "deletes chosen tag_change", %{conn: conn, tag_change: tag_change} do
      conn = delete(conn, Routes.tag_change_path(conn, :delete, tag_change))
      assert redirected_to(conn) == Routes.tag_change_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.tag_change_path(conn, :show, tag_change))
      end
    end
  end

  defp create_tag_change(_) do
    tag_change = fixture(:tag_change)
    {:ok, tag_change: tag_change}
  end
end
