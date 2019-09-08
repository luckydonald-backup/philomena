defmodule PhilomenaWeb.Admin.SubnetController do
  use PhilomenaWeb, :controller

  alias Philomena.Bans
  alias Philomena.Bans.Subnet

  def index(conn, _params) do
    subnet_bans = Bans.list_subnet_bans()
    render(conn, "index.html", subnet_bans: subnet_bans)
  end

  def new(conn, _params) do
    changeset = Bans.change_subnet(%Subnet{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"subnet" => subnet_params}) do
    case Bans.create_subnet(subnet_params) do
      {:ok, subnet} ->
        conn
        |> put_flash(:info, "Subnet created successfully.")
        |> redirect(to: Routes.admin_subnet_path(conn, :show, subnet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    subnet = Bans.get_subnet!(id)
    render(conn, "show.html", subnet: subnet)
  end

  def edit(conn, %{"id" => id}) do
    subnet = Bans.get_subnet!(id)
    changeset = Bans.change_subnet(subnet)
    render(conn, "edit.html", subnet: subnet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "subnet" => subnet_params}) do
    subnet = Bans.get_subnet!(id)

    case Bans.update_subnet(subnet, subnet_params) do
      {:ok, subnet} ->
        conn
        |> put_flash(:info, "Subnet updated successfully.")
        |> redirect(to: Routes.admin_subnet_path(conn, :show, subnet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", subnet: subnet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    subnet = Bans.get_subnet!(id)
    {:ok, _subnet} = Bans.delete_subnet(subnet)

    conn
    |> put_flash(:info, "Subnet deleted successfully.")
    |> redirect(to: Routes.admin_subnet_path(conn, :index))
  end
end
