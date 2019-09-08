defmodule PhilomenaWeb.ChangelogControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Changelogs

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:changelog) do
    {:ok, changelog} = Changelogs.create_changelog(@create_attrs)
    changelog
  end

  describe "index" do
    test "lists all changelogs", %{conn: conn} do
      conn = get(conn, Routes.changelog_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Changelogs"
    end
  end

  describe "new changelog" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.changelog_path(conn, :new))
      assert html_response(conn, 200) =~ "New Changelog"
    end
  end

  describe "create changelog" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.changelog_path(conn, :create), changelog: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.changelog_path(conn, :show, id)

      conn = get(conn, Routes.changelog_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Changelog"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.changelog_path(conn, :create), changelog: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Changelog"
    end
  end

  describe "edit changelog" do
    setup [:create_changelog]

    test "renders form for editing chosen changelog", %{conn: conn, changelog: changelog} do
      conn = get(conn, Routes.changelog_path(conn, :edit, changelog))
      assert html_response(conn, 200) =~ "Edit Changelog"
    end
  end

  describe "update changelog" do
    setup [:create_changelog]

    test "redirects when data is valid", %{conn: conn, changelog: changelog} do
      conn = put(conn, Routes.changelog_path(conn, :update, changelog), changelog: @update_attrs)
      assert redirected_to(conn) == Routes.changelog_path(conn, :show, changelog)

      conn = get(conn, Routes.changelog_path(conn, :show, changelog))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, changelog: changelog} do
      conn = put(conn, Routes.changelog_path(conn, :update, changelog), changelog: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Changelog"
    end
  end

  describe "delete changelog" do
    setup [:create_changelog]

    test "deletes chosen changelog", %{conn: conn, changelog: changelog} do
      conn = delete(conn, Routes.changelog_path(conn, :delete, changelog))
      assert redirected_to(conn) == Routes.changelog_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.changelog_path(conn, :show, changelog))
      end
    end
  end

  defp create_changelog(_) do
    changelog = fixture(:changelog)
    {:ok, changelog: changelog}
  end
end
