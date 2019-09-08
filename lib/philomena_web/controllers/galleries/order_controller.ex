defmodule PhilomenaWeb.Galleries.OrderController do
  use PhilomenaWeb, :controller

  alias Philomena.Galleries
  alias Philomena.Galleries.Order

  def index(conn, _params) do
    order = Galleries.list_order()
    render(conn, "index.html", order: order)
  end

  def new(conn, _params) do
    changeset = Galleries.change_order(%Order{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"order" => order_params}) do
    case Galleries.create_order(order_params) do
      {:ok, order} ->
        conn
        |> put_flash(:info, "Order created successfully.")
        |> redirect(to: Routes.galleries_order_path(conn, :show, order))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    order = Galleries.get_order!(id)
    render(conn, "show.html", order: order)
  end

  def edit(conn, %{"id" => id}) do
    order = Galleries.get_order!(id)
    changeset = Galleries.change_order(order)
    render(conn, "edit.html", order: order, changeset: changeset)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Galleries.get_order!(id)

    case Galleries.update_order(order, order_params) do
      {:ok, order} ->
        conn
        |> put_flash(:info, "Order updated successfully.")
        |> redirect(to: Routes.galleries_order_path(conn, :show, order))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", order: order, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    order = Galleries.get_order!(id)
    {:ok, _order} = Galleries.delete_order(order)

    conn
    |> put_flash(:info, "Order deleted successfully.")
    |> redirect(to: Routes.galleries_order_path(conn, :index))
  end
end
