defmodule PhilomenaWeb.TagChangeController do
  use PhilomenaWeb, :controller

  alias Philomena.TagChanges
  alias Philomena.TagChanges.TagChange

  def index(conn, _params) do
    tag_changes = TagChanges.list_tag_changes()
    render(conn, "index.html", tag_changes: tag_changes)
  end

  def new(conn, _params) do
    changeset = TagChanges.change_tag_change(%TagChange{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tag_change" => tag_change_params}) do
    case TagChanges.create_tag_change(tag_change_params) do
      {:ok, tag_change} ->
        conn
        |> put_flash(:info, "Tag change created successfully.")
        |> redirect(to: Routes.tag_change_path(conn, :show, tag_change))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tag_change = TagChanges.get_tag_change!(id)
    render(conn, "show.html", tag_change: tag_change)
  end

  def edit(conn, %{"id" => id}) do
    tag_change = TagChanges.get_tag_change!(id)
    changeset = TagChanges.change_tag_change(tag_change)
    render(conn, "edit.html", tag_change: tag_change, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tag_change" => tag_change_params}) do
    tag_change = TagChanges.get_tag_change!(id)

    case TagChanges.update_tag_change(tag_change, tag_change_params) do
      {:ok, tag_change} ->
        conn
        |> put_flash(:info, "Tag change updated successfully.")
        |> redirect(to: Routes.tag_change_path(conn, :show, tag_change))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tag_change: tag_change, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag_change = TagChanges.get_tag_change!(id)
    {:ok, _tag_change} = TagChanges.delete_tag_change(tag_change)

    conn
    |> put_flash(:info, "Tag change deleted successfully.")
    |> redirect(to: Routes.tag_change_path(conn, :index))
  end
end
