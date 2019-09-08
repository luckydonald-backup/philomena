defmodule PhilomenaWeb.Images.TagLockController do
  use PhilomenaWeb, :controller

  alias Philomena.Images
  alias Philomena.Images.TagLock

  def index(conn, _params) do
    tag_locks = Images.list_tag_locks()
    render(conn, "index.html", tag_locks: tag_locks)
  end

  def new(conn, _params) do
    changeset = Images.change_tag_lock(%TagLock{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tag_lock" => tag_lock_params}) do
    case Images.create_tag_lock(tag_lock_params) do
      {:ok, tag_lock} ->
        conn
        |> put_flash(:info, "Tag lock created successfully.")
        |> redirect(to: Routes.images_tag_lock_path(conn, :show, tag_lock))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tag_lock = Images.get_tag_lock!(id)
    render(conn, "show.html", tag_lock: tag_lock)
  end

  def edit(conn, %{"id" => id}) do
    tag_lock = Images.get_tag_lock!(id)
    changeset = Images.change_tag_lock(tag_lock)
    render(conn, "edit.html", tag_lock: tag_lock, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tag_lock" => tag_lock_params}) do
    tag_lock = Images.get_tag_lock!(id)

    case Images.update_tag_lock(tag_lock, tag_lock_params) do
      {:ok, tag_lock} ->
        conn
        |> put_flash(:info, "Tag lock updated successfully.")
        |> redirect(to: Routes.images_tag_lock_path(conn, :show, tag_lock))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tag_lock: tag_lock, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag_lock = Images.get_tag_lock!(id)
    {:ok, _tag_lock} = Images.delete_tag_lock(tag_lock)

    conn
    |> put_flash(:info, "Tag lock deleted successfully.")
    |> redirect(to: Routes.images_tag_lock_path(conn, :index))
  end
end
