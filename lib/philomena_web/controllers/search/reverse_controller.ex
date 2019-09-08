defmodule PhilomenaWeb.Search.ReverseController do
  use PhilomenaWeb, :controller

  alias Philomena.Search
  alias Philomena.Search.Reverse

  def index(conn, _params) do
    reverse = Search.list_reverse()
    render(conn, "index.html", reverse: reverse)
  end

  def new(conn, _params) do
    changeset = Search.change_reverse(%Reverse{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"reverse" => reverse_params}) do
    case Search.create_reverse(reverse_params) do
      {:ok, reverse} ->
        conn
        |> put_flash(:info, "Reverse created successfully.")
        |> redirect(to: Routes.search_reverse_path(conn, :show, reverse))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    reverse = Search.get_reverse!(id)
    render(conn, "show.html", reverse: reverse)
  end

  def edit(conn, %{"id" => id}) do
    reverse = Search.get_reverse!(id)
    changeset = Search.change_reverse(reverse)
    render(conn, "edit.html", reverse: reverse, changeset: changeset)
  end

  def update(conn, %{"id" => id, "reverse" => reverse_params}) do
    reverse = Search.get_reverse!(id)

    case Search.update_reverse(reverse, reverse_params) do
      {:ok, reverse} ->
        conn
        |> put_flash(:info, "Reverse updated successfully.")
        |> redirect(to: Routes.search_reverse_path(conn, :show, reverse))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", reverse: reverse, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    reverse = Search.get_reverse!(id)
    {:ok, _reverse} = Search.delete_reverse(reverse)

    conn
    |> put_flash(:info, "Reverse deleted successfully.")
    |> redirect(to: Routes.search_reverse_path(conn, :index))
  end
end
