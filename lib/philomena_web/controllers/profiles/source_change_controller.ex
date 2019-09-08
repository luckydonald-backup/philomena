defmodule PhilomenaWeb.Profiles.SourceChangeController do
  use PhilomenaWeb, :controller

  alias Philomena.Profiles
  alias Philomena.Profiles.SourceChange

  def index(conn, _params) do
    source_changes = Profiles.list_source_changes()
    render(conn, "index.html", source_changes: source_changes)
  end

  def new(conn, _params) do
    changeset = Profiles.change_source_change(%SourceChange{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"source_change" => source_change_params}) do
    case Profiles.create_source_change(source_change_params) do
      {:ok, source_change} ->
        conn
        |> put_flash(:info, "Source change created successfully.")
        |> redirect(to: Routes.profiles_source_change_path(conn, :show, source_change))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    source_change = Profiles.get_source_change!(id)
    render(conn, "show.html", source_change: source_change)
  end

  def edit(conn, %{"id" => id}) do
    source_change = Profiles.get_source_change!(id)
    changeset = Profiles.change_source_change(source_change)
    render(conn, "edit.html", source_change: source_change, changeset: changeset)
  end

  def update(conn, %{"id" => id, "source_change" => source_change_params}) do
    source_change = Profiles.get_source_change!(id)

    case Profiles.update_source_change(source_change, source_change_params) do
      {:ok, source_change} ->
        conn
        |> put_flash(:info, "Source change updated successfully.")
        |> redirect(to: Routes.profiles_source_change_path(conn, :show, source_change))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", source_change: source_change, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    source_change = Profiles.get_source_change!(id)
    {:ok, _source_change} = Profiles.delete_source_change(source_change)

    conn
    |> put_flash(:info, "Source change deleted successfully.")
    |> redirect(to: Routes.profiles_source_change_path(conn, :index))
  end
end
