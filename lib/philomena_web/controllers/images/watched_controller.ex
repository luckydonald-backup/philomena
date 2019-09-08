defmodule PhilomenaWeb.Images.WatchedController do
  use PhilomenaWeb, :controller

  alias Philomena.Images
  alias Philomena.Images.Watched

  def index(conn, _params) do
    watched = Images.list_watched()
    render(conn, "index.html", watched: watched)
  end

  def new(conn, _params) do
    changeset = Images.change_watched(%Watched{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"watched" => watched_params}) do
    case Images.create_watched(watched_params) do
      {:ok, watched} ->
        conn
        |> put_flash(:info, "Watched created successfully.")
        |> redirect(to: Routes.images_watched_path(conn, :show, watched))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    watched = Images.get_watched!(id)
    render(conn, "show.html", watched: watched)
  end

  def edit(conn, %{"id" => id}) do
    watched = Images.get_watched!(id)
    changeset = Images.change_watched(watched)
    render(conn, "edit.html", watched: watched, changeset: changeset)
  end

  def update(conn, %{"id" => id, "watched" => watched_params}) do
    watched = Images.get_watched!(id)

    case Images.update_watched(watched, watched_params) do
      {:ok, watched} ->
        conn
        |> put_flash(:info, "Watched updated successfully.")
        |> redirect(to: Routes.images_watched_path(conn, :show, watched))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", watched: watched, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    watched = Images.get_watched!(id)
    {:ok, _watched} = Images.delete_watched(watched)

    conn
    |> put_flash(:info, "Watched deleted successfully.")
    |> redirect(to: Routes.images_watched_path(conn, :index))
  end
end
