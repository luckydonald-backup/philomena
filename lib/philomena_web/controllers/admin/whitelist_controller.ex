defmodule PhilomenaWeb.Admin.WhitelistController do
  use PhilomenaWeb, :controller

  alias Philomena.Users
  alias Philomena.Users.Whitelist

  def index(conn, _params) do
    user_whitelists = Users.list_user_whitelists()
    render(conn, "index.html", user_whitelists: user_whitelists)
  end

  def new(conn, _params) do
    changeset = Users.change_whitelist(%Whitelist{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"whitelist" => whitelist_params}) do
    case Users.create_whitelist(whitelist_params) do
      {:ok, whitelist} ->
        conn
        |> put_flash(:info, "Whitelist created successfully.")
        |> redirect(to: Routes.admin_whitelist_path(conn, :show, whitelist))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    whitelist = Users.get_whitelist!(id)
    render(conn, "show.html", whitelist: whitelist)
  end

  def edit(conn, %{"id" => id}) do
    whitelist = Users.get_whitelist!(id)
    changeset = Users.change_whitelist(whitelist)
    render(conn, "edit.html", whitelist: whitelist, changeset: changeset)
  end

  def update(conn, %{"id" => id, "whitelist" => whitelist_params}) do
    whitelist = Users.get_whitelist!(id)

    case Users.update_whitelist(whitelist, whitelist_params) do
      {:ok, whitelist} ->
        conn
        |> put_flash(:info, "Whitelist updated successfully.")
        |> redirect(to: Routes.admin_whitelist_path(conn, :show, whitelist))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", whitelist: whitelist, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    whitelist = Users.get_whitelist!(id)
    {:ok, _whitelist} = Users.delete_whitelist(whitelist)

    conn
    |> put_flash(:info, "Whitelist deleted successfully.")
    |> redirect(to: Routes.admin_whitelist_path(conn, :index))
  end
end
