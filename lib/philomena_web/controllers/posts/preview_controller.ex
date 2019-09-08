defmodule PhilomenaWeb.Posts.PreviewController do
  use PhilomenaWeb, :controller

  alias Philomena.Posts
  alias Philomena.Posts.Preview

  def index(conn, _params) do
    preview = Posts.list_preview()
    render(conn, "index.html", preview: preview)
  end

  def new(conn, _params) do
    changeset = Posts.change_preview(%Preview{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"preview" => preview_params}) do
    case Posts.create_preview(preview_params) do
      {:ok, preview} ->
        conn
        |> put_flash(:info, "Preview created successfully.")
        |> redirect(to: Routes.posts_preview_path(conn, :show, preview))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    preview = Posts.get_preview!(id)
    render(conn, "show.html", preview: preview)
  end

  def edit(conn, %{"id" => id}) do
    preview = Posts.get_preview!(id)
    changeset = Posts.change_preview(preview)
    render(conn, "edit.html", preview: preview, changeset: changeset)
  end

  def update(conn, %{"id" => id, "preview" => preview_params}) do
    preview = Posts.get_preview!(id)

    case Posts.update_preview(preview, preview_params) do
      {:ok, preview} ->
        conn
        |> put_flash(:info, "Preview updated successfully.")
        |> redirect(to: Routes.posts_preview_path(conn, :show, preview))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", preview: preview, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    preview = Posts.get_preview!(id)
    {:ok, _preview} = Posts.delete_preview(preview)

    conn
    |> put_flash(:info, "Preview deleted successfully.")
    |> redirect(to: Routes.posts_preview_path(conn, :index))
  end
end
