defmodule PhilomenaWeb.Images.DescriptionLockController do
  use PhilomenaWeb, :controller

  alias Philomena.Images
  alias Philomena.Images.DescriptionLock

  def index(conn, _params) do
    description_locks = Images.list_description_locks()
    render(conn, "index.html", description_locks: description_locks)
  end

  def new(conn, _params) do
    changeset = Images.change_description_lock(%DescriptionLock{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"description_lock" => description_lock_params}) do
    case Images.create_description_lock(description_lock_params) do
      {:ok, description_lock} ->
        conn
        |> put_flash(:info, "Description lock created successfully.")
        |> redirect(to: Routes.images_description_lock_path(conn, :show, description_lock))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    description_lock = Images.get_description_lock!(id)
    render(conn, "show.html", description_lock: description_lock)
  end

  def edit(conn, %{"id" => id}) do
    description_lock = Images.get_description_lock!(id)
    changeset = Images.change_description_lock(description_lock)
    render(conn, "edit.html", description_lock: description_lock, changeset: changeset)
  end

  def update(conn, %{"id" => id, "description_lock" => description_lock_params}) do
    description_lock = Images.get_description_lock!(id)

    case Images.update_description_lock(description_lock, description_lock_params) do
      {:ok, description_lock} ->
        conn
        |> put_flash(:info, "Description lock updated successfully.")
        |> redirect(to: Routes.images_description_lock_path(conn, :show, description_lock))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", description_lock: description_lock, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    description_lock = Images.get_description_lock!(id)
    {:ok, _description_lock} = Images.delete_description_lock(description_lock)

    conn
    |> put_flash(:info, "Description lock deleted successfully.")
    |> redirect(to: Routes.images_description_lock_path(conn, :index))
  end
end
