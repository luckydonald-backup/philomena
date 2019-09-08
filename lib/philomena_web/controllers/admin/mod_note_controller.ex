defmodule PhilomenaWeb.Admin.ModNoteController do
  use PhilomenaWeb, :controller

  alias Philomena.ModNotes
  alias Philomena.ModNotes.ModNote

  def index(conn, _params) do
    mod_notes = ModNotes.list_mod_notes()
    render(conn, "index.html", mod_notes: mod_notes)
  end

  def new(conn, _params) do
    changeset = ModNotes.change_mod_note(%ModNote{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"mod_note" => mod_note_params}) do
    case ModNotes.create_mod_note(mod_note_params) do
      {:ok, mod_note} ->
        conn
        |> put_flash(:info, "Mod note created successfully.")
        |> redirect(to: Routes.admin_mod_note_path(conn, :show, mod_note))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    mod_note = ModNotes.get_mod_note!(id)
    render(conn, "show.html", mod_note: mod_note)
  end

  def edit(conn, %{"id" => id}) do
    mod_note = ModNotes.get_mod_note!(id)
    changeset = ModNotes.change_mod_note(mod_note)
    render(conn, "edit.html", mod_note: mod_note, changeset: changeset)
  end

  def update(conn, %{"id" => id, "mod_note" => mod_note_params}) do
    mod_note = ModNotes.get_mod_note!(id)

    case ModNotes.update_mod_note(mod_note, mod_note_params) do
      {:ok, mod_note} ->
        conn
        |> put_flash(:info, "Mod note updated successfully.")
        |> redirect(to: Routes.admin_mod_note_path(conn, :show, mod_note))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", mod_note: mod_note, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    mod_note = ModNotes.get_mod_note!(id)
    {:ok, _mod_note} = ModNotes.delete_mod_note(mod_note)

    conn
    |> put_flash(:info, "Mod note deleted successfully.")
    |> redirect(to: Routes.admin_mod_note_path(conn, :index))
  end
end
