defmodule PhilomenaWeb.Images.CommentLockController do
  use PhilomenaWeb, :controller

  alias Philomena.Images
  alias Philomena.Images.CommentLock

  def index(conn, _params) do
    comment_locks = Images.list_comment_locks()
    render(conn, "index.html", comment_locks: comment_locks)
  end

  def new(conn, _params) do
    changeset = Images.change_comment_lock(%CommentLock{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"comment_lock" => comment_lock_params}) do
    case Images.create_comment_lock(comment_lock_params) do
      {:ok, comment_lock} ->
        conn
        |> put_flash(:info, "Comment lock created successfully.")
        |> redirect(to: Routes.images_comment_lock_path(conn, :show, comment_lock))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    comment_lock = Images.get_comment_lock!(id)
    render(conn, "show.html", comment_lock: comment_lock)
  end

  def edit(conn, %{"id" => id}) do
    comment_lock = Images.get_comment_lock!(id)
    changeset = Images.change_comment_lock(comment_lock)
    render(conn, "edit.html", comment_lock: comment_lock, changeset: changeset)
  end

  def update(conn, %{"id" => id, "comment_lock" => comment_lock_params}) do
    comment_lock = Images.get_comment_lock!(id)

    case Images.update_comment_lock(comment_lock, comment_lock_params) do
      {:ok, comment_lock} ->
        conn
        |> put_flash(:info, "Comment lock updated successfully.")
        |> redirect(to: Routes.images_comment_lock_path(conn, :show, comment_lock))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", comment_lock: comment_lock, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment_lock = Images.get_comment_lock!(id)
    {:ok, _comment_lock} = Images.delete_comment_lock(comment_lock)

    conn
    |> put_flash(:info, "Comment lock deleted successfully.")
    |> redirect(to: Routes.images_comment_lock_path(conn, :index))
  end
end
