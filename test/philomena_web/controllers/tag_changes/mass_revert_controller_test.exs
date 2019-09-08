defmodule PhilomenaWeb.TagChanges.MassRevertControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.TagChanges

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:mass_revert) do
    {:ok, mass_revert} = TagChanges.create_mass_revert(@create_attrs)
    mass_revert
  end

  describe "index" do
    test "lists all mass_revert", %{conn: conn} do
      conn = get(conn, Routes.tag_changes_mass_revert_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Mass revert"
    end
  end

  describe "new mass_revert" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.tag_changes_mass_revert_path(conn, :new))
      assert html_response(conn, 200) =~ "New Mass revert"
    end
  end

  describe "create mass_revert" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.tag_changes_mass_revert_path(conn, :create), mass_revert: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.tag_changes_mass_revert_path(conn, :show, id)

      conn = get(conn, Routes.tag_changes_mass_revert_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Mass revert"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.tag_changes_mass_revert_path(conn, :create), mass_revert: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Mass revert"
    end
  end

  describe "edit mass_revert" do
    setup [:create_mass_revert]

    test "renders form for editing chosen mass_revert", %{conn: conn, mass_revert: mass_revert} do
      conn = get(conn, Routes.tag_changes_mass_revert_path(conn, :edit, mass_revert))
      assert html_response(conn, 200) =~ "Edit Mass revert"
    end
  end

  describe "update mass_revert" do
    setup [:create_mass_revert]

    test "redirects when data is valid", %{conn: conn, mass_revert: mass_revert} do
      conn = put(conn, Routes.tag_changes_mass_revert_path(conn, :update, mass_revert), mass_revert: @update_attrs)
      assert redirected_to(conn) == Routes.tag_changes_mass_revert_path(conn, :show, mass_revert)

      conn = get(conn, Routes.tag_changes_mass_revert_path(conn, :show, mass_revert))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, mass_revert: mass_revert} do
      conn = put(conn, Routes.tag_changes_mass_revert_path(conn, :update, mass_revert), mass_revert: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Mass revert"
    end
  end

  describe "delete mass_revert" do
    setup [:create_mass_revert]

    test "deletes chosen mass_revert", %{conn: conn, mass_revert: mass_revert} do
      conn = delete(conn, Routes.tag_changes_mass_revert_path(conn, :delete, mass_revert))
      assert redirected_to(conn) == Routes.tag_changes_mass_revert_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.tag_changes_mass_revert_path(conn, :show, mass_revert))
      end
    end
  end

  defp create_mass_revert(_) do
    mass_revert = fixture(:mass_revert)
    {:ok, mass_revert: mass_revert}
  end
end
