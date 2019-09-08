defmodule PhilomenaWeb.DnpEntries.RescindController do
  use PhilomenaWeb, :controller

  alias Philomena.DnpEntries
  alias Philomena.DnpEntries.Rescind

  def index(conn, _params) do
    rescinds = DnpEntries.list_rescinds()
    render(conn, "index.html", rescinds: rescinds)
  end

  def new(conn, _params) do
    changeset = DnpEntries.change_rescind(%Rescind{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"rescind" => rescind_params}) do
    case DnpEntries.create_rescind(rescind_params) do
      {:ok, rescind} ->
        conn
        |> put_flash(:info, "Rescind created successfully.")
        |> redirect(to: Routes.dnp_entries_rescind_path(conn, :show, rescind))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    rescind = DnpEntries.get_rescind!(id)
    render(conn, "show.html", rescind: rescind)
  end

  def edit(conn, %{"id" => id}) do
    rescind = DnpEntries.get_rescind!(id)
    changeset = DnpEntries.change_rescind(rescind)
    render(conn, "edit.html", rescind: rescind, changeset: changeset)
  end

  def update(conn, %{"id" => id, "rescind" => rescind_params}) do
    rescind = DnpEntries.get_rescind!(id)

    case DnpEntries.update_rescind(rescind, rescind_params) do
      {:ok, rescind} ->
        conn
        |> put_flash(:info, "Rescind updated successfully.")
        |> redirect(to: Routes.dnp_entries_rescind_path(conn, :show, rescind))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", rescind: rescind, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    rescind = DnpEntries.get_rescind!(id)
    {:ok, _rescind} = DnpEntries.delete_rescind(rescind)

    conn
    |> put_flash(:info, "Rescind deleted successfully.")
    |> redirect(to: Routes.dnp_entries_rescind_path(conn, :index))
  end
end
