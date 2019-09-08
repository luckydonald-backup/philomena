defmodule PhilomenaWeb.Topics.LockController do
  use PhilomenaWeb, :controller

  alias Philomena.Topics
  alias Philomena.Topics.Lock

  def index(conn, _params) do
    locks = Topics.list_locks()
    render(conn, "index.html", locks: locks)
  end

  def new(conn, _params) do
    changeset = Topics.change_lock(%Lock{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"lock" => lock_params}) do
    case Topics.create_lock(lock_params) do
      {:ok, lock} ->
        conn
        |> put_flash(:info, "Lock created successfully.")
        |> redirect(to: Routes.topics_lock_path(conn, :show, lock))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    lock = Topics.get_lock!(id)
    render(conn, "show.html", lock: lock)
  end

  def edit(conn, %{"id" => id}) do
    lock = Topics.get_lock!(id)
    changeset = Topics.change_lock(lock)
    render(conn, "edit.html", lock: lock, changeset: changeset)
  end

  def update(conn, %{"id" => id, "lock" => lock_params}) do
    lock = Topics.get_lock!(id)

    case Topics.update_lock(lock, lock_params) do
      {:ok, lock} ->
        conn
        |> put_flash(:info, "Lock updated successfully.")
        |> redirect(to: Routes.topics_lock_path(conn, :show, lock))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", lock: lock, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    lock = Topics.get_lock!(id)
    {:ok, _lock} = Topics.delete_lock(lock)

    conn
    |> put_flash(:info, "Lock deleted successfully.")
    |> redirect(to: Routes.topics_lock_path(conn, :index))
  end
end
