defmodule PhilomenaWeb.Admin.ModNoteControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.ModNotes

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:mod_note) do
    {:ok, mod_note} = ModNotes.create_mod_note(@create_attrs)
    mod_note
  end

  describe "index" do
    test "lists all mod_notes", %{conn: conn} do
      conn = get(conn, Routes.admin_mod_note_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Mod notes"
    end
  end

  describe "new mod_note" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.admin_mod_note_path(conn, :new))
      assert html_response(conn, 200) =~ "New Mod note"
    end
  end

  describe "create mod_note" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.admin_mod_note_path(conn, :create), mod_note: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_mod_note_path(conn, :show, id)

      conn = get(conn, Routes.admin_mod_note_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Mod note"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admin_mod_note_path(conn, :create), mod_note: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Mod note"
    end
  end

  describe "edit mod_note" do
    setup [:create_mod_note]

    test "renders form for editing chosen mod_note", %{conn: conn, mod_note: mod_note} do
      conn = get(conn, Routes.admin_mod_note_path(conn, :edit, mod_note))
      assert html_response(conn, 200) =~ "Edit Mod note"
    end
  end

  describe "update mod_note" do
    setup [:create_mod_note]

    test "redirects when data is valid", %{conn: conn, mod_note: mod_note} do
      conn = put(conn, Routes.admin_mod_note_path(conn, :update, mod_note), mod_note: @update_attrs)
      assert redirected_to(conn) == Routes.admin_mod_note_path(conn, :show, mod_note)

      conn = get(conn, Routes.admin_mod_note_path(conn, :show, mod_note))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, mod_note: mod_note} do
      conn = put(conn, Routes.admin_mod_note_path(conn, :update, mod_note), mod_note: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Mod note"
    end
  end

  describe "delete mod_note" do
    setup [:create_mod_note]

    test "deletes chosen mod_note", %{conn: conn, mod_note: mod_note} do
      conn = delete(conn, Routes.admin_mod_note_path(conn, :delete, mod_note))
      assert redirected_to(conn) == Routes.admin_mod_note_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.admin_mod_note_path(conn, :show, mod_note))
      end
    end
  end

  defp create_mod_note(_) do
    mod_note = fixture(:mod_note)
    {:ok, mod_note: mod_note}
  end
end
