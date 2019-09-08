defmodule PhilomenaWeb.Commissions.ItemController do
  use PhilomenaWeb, :controller

  alias Philomena.Commissions
  alias Philomena.Commissions.Item

  def index(conn, _params) do
    commission_items = Commissions.list_commission_items()
    render(conn, "index.html", commission_items: commission_items)
  end

  def new(conn, _params) do
    changeset = Commissions.change_item(%Item{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"item" => item_params}) do
    case Commissions.create_item(item_params) do
      {:ok, item} ->
        conn
        |> put_flash(:info, "Item created successfully.")
        |> redirect(to: Routes.commissions_item_path(conn, :show, item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    item = Commissions.get_item!(id)
    render(conn, "show.html", item: item)
  end

  def edit(conn, %{"id" => id}) do
    item = Commissions.get_item!(id)
    changeset = Commissions.change_item(item)
    render(conn, "edit.html", item: item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Commissions.get_item!(id)

    case Commissions.update_item(item, item_params) do
      {:ok, item} ->
        conn
        |> put_flash(:info, "Item updated successfully.")
        |> redirect(to: Routes.commissions_item_path(conn, :show, item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", item: item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    item = Commissions.get_item!(id)
    {:ok, _item} = Commissions.delete_item(item)

    conn
    |> put_flash(:info, "Item deleted successfully.")
    |> redirect(to: Routes.commissions_item_path(conn, :index))
  end
end
