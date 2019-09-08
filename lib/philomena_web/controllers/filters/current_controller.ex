defmodule PhilomenaWeb.Filters.CurrentController do
  use PhilomenaWeb, :controller

  alias Philomena.Filters
  alias Philomena.Filters.Current

  def index(conn, _params) do
    current = Filters.list_current()
    render(conn, "index.html", current: current)
  end

  def new(conn, _params) do
    changeset = Filters.change_current(%Current{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"current" => current_params}) do
    case Filters.create_current(current_params) do
      {:ok, current} ->
        conn
        |> put_flash(:info, "Current created successfully.")
        |> redirect(to: Routes.filters_current_path(conn, :show, current))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    current = Filters.get_current!(id)
    render(conn, "show.html", current: current)
  end

  def edit(conn, %{"id" => id}) do
    current = Filters.get_current!(id)
    changeset = Filters.change_current(current)
    render(conn, "edit.html", current: current, changeset: changeset)
  end

  def update(conn, %{"id" => id, "current" => current_params}) do
    current = Filters.get_current!(id)

    case Filters.update_current(current, current_params) do
      {:ok, current} ->
        conn
        |> put_flash(:info, "Current updated successfully.")
        |> redirect(to: Routes.filters_current_path(conn, :show, current))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", current: current, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    current = Filters.get_current!(id)
    {:ok, _current} = Filters.delete_current(current)

    conn
    |> put_flash(:info, "Current deleted successfully.")
    |> redirect(to: Routes.filters_current_path(conn, :index))
  end
end
