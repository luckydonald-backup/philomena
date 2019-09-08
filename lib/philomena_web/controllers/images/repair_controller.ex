defmodule PhilomenaWeb.Images.RepairController do
  use PhilomenaWeb, :controller

  alias Philomena.Images
  alias Philomena.Images.Repair

  def index(conn, _params) do
    repairs = Images.list_repairs()
    render(conn, "index.html", repairs: repairs)
  end

  def new(conn, _params) do
    changeset = Images.change_repair(%Repair{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"repair" => repair_params}) do
    case Images.create_repair(repair_params) do
      {:ok, repair} ->
        conn
        |> put_flash(:info, "Repair created successfully.")
        |> redirect(to: Routes.images_repair_path(conn, :show, repair))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    repair = Images.get_repair!(id)
    render(conn, "show.html", repair: repair)
  end

  def edit(conn, %{"id" => id}) do
    repair = Images.get_repair!(id)
    changeset = Images.change_repair(repair)
    render(conn, "edit.html", repair: repair, changeset: changeset)
  end

  def update(conn, %{"id" => id, "repair" => repair_params}) do
    repair = Images.get_repair!(id)

    case Images.update_repair(repair, repair_params) do
      {:ok, repair} ->
        conn
        |> put_flash(:info, "Repair updated successfully.")
        |> redirect(to: Routes.images_repair_path(conn, :show, repair))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", repair: repair, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    repair = Images.get_repair!(id)
    {:ok, _repair} = Images.delete_repair(repair)

    conn
    |> put_flash(:info, "Repair deleted successfully.")
    |> redirect(to: Routes.images_repair_path(conn, :index))
  end
end
