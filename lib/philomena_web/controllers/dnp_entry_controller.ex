defmodule PhilomenaWeb.DnpEntryController do
  use PhilomenaWeb, :controller

  alias Philomena.DnpEntries
  alias Philomena.DnpEntries.DnpEntry

  def index(conn, _params) do
    dnp_entries = DnpEntries.list_dnp_entries()
    render(conn, "index.html", dnp_entries: dnp_entries)
  end

  def new(conn, _params) do
    changeset = DnpEntries.change_dnp_entry(%DnpEntry{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"dnp_entry" => dnp_entry_params}) do
    case DnpEntries.create_dnp_entry(dnp_entry_params) do
      {:ok, dnp_entry} ->
        conn
        |> put_flash(:info, "Dnp entry created successfully.")
        |> redirect(to: Routes.dnp_entry_path(conn, :show, dnp_entry))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    dnp_entry = DnpEntries.get_dnp_entry!(id)
    render(conn, "show.html", dnp_entry: dnp_entry)
  end

  def edit(conn, %{"id" => id}) do
    dnp_entry = DnpEntries.get_dnp_entry!(id)
    changeset = DnpEntries.change_dnp_entry(dnp_entry)
    render(conn, "edit.html", dnp_entry: dnp_entry, changeset: changeset)
  end

  def update(conn, %{"id" => id, "dnp_entry" => dnp_entry_params}) do
    dnp_entry = DnpEntries.get_dnp_entry!(id)

    case DnpEntries.update_dnp_entry(dnp_entry, dnp_entry_params) do
      {:ok, dnp_entry} ->
        conn
        |> put_flash(:info, "Dnp entry updated successfully.")
        |> redirect(to: Routes.dnp_entry_path(conn, :show, dnp_entry))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", dnp_entry: dnp_entry, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    dnp_entry = DnpEntries.get_dnp_entry!(id)
    {:ok, _dnp_entry} = DnpEntries.delete_dnp_entry(dnp_entry)

    conn
    |> put_flash(:info, "Dnp entry deleted successfully.")
    |> redirect(to: Routes.dnp_entry_path(conn, :index))
  end
end
