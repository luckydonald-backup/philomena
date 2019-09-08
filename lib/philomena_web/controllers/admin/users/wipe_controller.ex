defmodule PhilomenaWeb.Admin.Users.WipeController do
  use PhilomenaWeb, :controller

  alias Philomena.User
  alias Philomena.User.Wipe

  def index(conn, _params) do
    users = User.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.change_wipe(%Wipe{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"wipe" => wipe_params}) do
    case User.create_wipe(wipe_params) do
      {:ok, wipe} ->
        conn
        |> put_flash(:info, "Wipe created successfully.")
        |> redirect(to: Routes.admin_users_wipe_path(conn, :show, wipe))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    wipe = User.get_wipe!(id)
    render(conn, "show.html", wipe: wipe)
  end

  def edit(conn, %{"id" => id}) do
    wipe = User.get_wipe!(id)
    changeset = User.change_wipe(wipe)
    render(conn, "edit.html", wipe: wipe, changeset: changeset)
  end

  def update(conn, %{"id" => id, "wipe" => wipe_params}) do
    wipe = User.get_wipe!(id)

    case User.update_wipe(wipe, wipe_params) do
      {:ok, wipe} ->
        conn
        |> put_flash(:info, "Wipe updated successfully.")
        |> redirect(to: Routes.admin_users_wipe_path(conn, :show, wipe))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", wipe: wipe, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    wipe = User.get_wipe!(id)
    {:ok, _wipe} = User.delete_wipe(wipe)

    conn
    |> put_flash(:info, "Wipe deleted successfully.")
    |> redirect(to: Routes.admin_users_wipe_path(conn, :index))
  end
end
