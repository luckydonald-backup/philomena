defmodule PhilomenaWeb.SpoilerTypeController do
  use PhilomenaWeb, :controller

  alias Philomena.SpoilerTypes
  alias Philomena.SpoilerTypes.SpoilerType

  def index(conn, _params) do
    spoiler_types = SpoilerTypes.list_spoiler_types()
    render(conn, "index.html", spoiler_types: spoiler_types)
  end

  def new(conn, _params) do
    changeset = SpoilerTypes.change_spoiler_type(%SpoilerType{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"spoiler_type" => spoiler_type_params}) do
    case SpoilerTypes.create_spoiler_type(spoiler_type_params) do
      {:ok, spoiler_type} ->
        conn
        |> put_flash(:info, "Spoiler type created successfully.")
        |> redirect(to: Routes.spoiler_type_path(conn, :show, spoiler_type))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    spoiler_type = SpoilerTypes.get_spoiler_type!(id)
    render(conn, "show.html", spoiler_type: spoiler_type)
  end

  def edit(conn, %{"id" => id}) do
    spoiler_type = SpoilerTypes.get_spoiler_type!(id)
    changeset = SpoilerTypes.change_spoiler_type(spoiler_type)
    render(conn, "edit.html", spoiler_type: spoiler_type, changeset: changeset)
  end

  def update(conn, %{"id" => id, "spoiler_type" => spoiler_type_params}) do
    spoiler_type = SpoilerTypes.get_spoiler_type!(id)

    case SpoilerTypes.update_spoiler_type(spoiler_type, spoiler_type_params) do
      {:ok, spoiler_type} ->
        conn
        |> put_flash(:info, "Spoiler type updated successfully.")
        |> redirect(to: Routes.spoiler_type_path(conn, :show, spoiler_type))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", spoiler_type: spoiler_type, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    spoiler_type = SpoilerTypes.get_spoiler_type!(id)
    {:ok, _spoiler_type} = SpoilerTypes.delete_spoiler_type(spoiler_type)

    conn
    |> put_flash(:info, "Spoiler type deleted successfully.")
    |> redirect(to: Routes.spoiler_type_path(conn, :index))
  end
end
