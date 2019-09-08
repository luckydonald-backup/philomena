defmodule PhilomenaWeb.Admin.UserController do
  use PhilomenaWeb, :controller

  alias Philomena.Bans
  alias Philomena.Bans.User

  def index(conn, _params) do
    user_bans = Bans.list_user_bans()
    render(conn, "index.html", user_bans: user_bans)
  end

  def new(conn, _params) do
    changeset = Bans.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Bans.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.admin_user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Bans.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Bans.get_user!(id)
    changeset = Bans.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Bans.get_user!(id)

    case Bans.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.admin_user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Bans.get_user!(id)
    {:ok, _user} = Bans.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.admin_user_path(conn, :index))
  end
end
