defmodule PhilomenaWeb.Admin.Users.ActivationController do
  use PhilomenaWeb, :controller

  alias Philomena.User
  alias Philomena.User.Activation

  def index(conn, _params) do
    users = User.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.change_activation(%Activation{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"activation" => activation_params}) do
    case User.create_activation(activation_params) do
      {:ok, activation} ->
        conn
        |> put_flash(:info, "Activation created successfully.")
        |> redirect(to: Routes.admin_users_activation_path(conn, :show, activation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    activation = User.get_activation!(id)
    render(conn, "show.html", activation: activation)
  end

  def edit(conn, %{"id" => id}) do
    activation = User.get_activation!(id)
    changeset = User.change_activation(activation)
    render(conn, "edit.html", activation: activation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "activation" => activation_params}) do
    activation = User.get_activation!(id)

    case User.update_activation(activation, activation_params) do
      {:ok, activation} ->
        conn
        |> put_flash(:info, "Activation updated successfully.")
        |> redirect(to: Routes.admin_users_activation_path(conn, :show, activation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", activation: activation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    activation = User.get_activation!(id)
    {:ok, _activation} = User.delete_activation(activation)

    conn
    |> put_flash(:info, "Activation deleted successfully.")
    |> redirect(to: Routes.admin_users_activation_path(conn, :index))
  end
end
