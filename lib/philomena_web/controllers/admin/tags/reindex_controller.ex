defmodule PhilomenaWeb.Admin.Tags.ReindexController do
  use PhilomenaWeb, :controller

  alias Philomena.Tags
  alias Philomena.Tags.Reindex

  def index(conn, _params) do
    tags = Tags.list_tags()
    render(conn, "index.html", tags: tags)
  end

  def new(conn, _params) do
    changeset = Tags.change_reindex(%Reindex{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"reindex" => reindex_params}) do
    case Tags.create_reindex(reindex_params) do
      {:ok, reindex} ->
        conn
        |> put_flash(:info, "Reindex created successfully.")
        |> redirect(to: Routes.admin_tags_reindex_path(conn, :show, reindex))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    reindex = Tags.get_reindex!(id)
    render(conn, "show.html", reindex: reindex)
  end

  def edit(conn, %{"id" => id}) do
    reindex = Tags.get_reindex!(id)
    changeset = Tags.change_reindex(reindex)
    render(conn, "edit.html", reindex: reindex, changeset: changeset)
  end

  def update(conn, %{"id" => id, "reindex" => reindex_params}) do
    reindex = Tags.get_reindex!(id)

    case Tags.update_reindex(reindex, reindex_params) do
      {:ok, reindex} ->
        conn
        |> put_flash(:info, "Reindex updated successfully.")
        |> redirect(to: Routes.admin_tags_reindex_path(conn, :show, reindex))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", reindex: reindex, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    reindex = Tags.get_reindex!(id)
    {:ok, _reindex} = Tags.delete_reindex(reindex)

    conn
    |> put_flash(:info, "Reindex deleted successfully.")
    |> redirect(to: Routes.admin_tags_reindex_path(conn, :index))
  end
end
