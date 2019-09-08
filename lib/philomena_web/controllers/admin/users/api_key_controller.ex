defmodule PhilomenaWeb.Admin.Users.ApiKeyController do
  use PhilomenaWeb, :controller

  alias Philomena.User
  alias Philomena.User.ApiKey

  def index(conn, _params) do
    users = User.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.change_api_key(%ApiKey{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"api_key" => api_key_params}) do
    case User.create_api_key(api_key_params) do
      {:ok, api_key} ->
        conn
        |> put_flash(:info, "Api key created successfully.")
        |> redirect(to: Routes.admin_users_api_key_path(conn, :show, api_key))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    api_key = User.get_api_key!(id)
    render(conn, "show.html", api_key: api_key)
  end

  def edit(conn, %{"id" => id}) do
    api_key = User.get_api_key!(id)
    changeset = User.change_api_key(api_key)
    render(conn, "edit.html", api_key: api_key, changeset: changeset)
  end

  def update(conn, %{"id" => id, "api_key" => api_key_params}) do
    api_key = User.get_api_key!(id)

    case User.update_api_key(api_key, api_key_params) do
      {:ok, api_key} ->
        conn
        |> put_flash(:info, "Api key updated successfully.")
        |> redirect(to: Routes.admin_users_api_key_path(conn, :show, api_key))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", api_key: api_key, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    api_key = User.get_api_key!(id)
    {:ok, _api_key} = User.delete_api_key(api_key)

    conn
    |> put_flash(:info, "Api key deleted successfully.")
    |> redirect(to: Routes.admin_users_api_key_path(conn, :index))
  end
end
