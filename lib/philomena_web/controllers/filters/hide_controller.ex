defmodule PhilomenaWeb.Filters.HideController do
  use PhilomenaWeb, :controller

  alias Philomena.Filters
  alias Philomena.Filters.Hide

  def index(conn, _params) do
    hide = Filters.list_hide()
    render(conn, "index.html", hide: hide)
  end

  def new(conn, _params) do
    changeset = Filters.change_hide(%Hide{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"hide" => hide_params}) do
    case Filters.create_hide(hide_params) do
      {:ok, hide} ->
        conn
        |> put_flash(:info, "Hide created successfully.")
        |> redirect(to: Routes.filters_hide_path(conn, :show, hide))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    hide = Filters.get_hide!(id)
    render(conn, "show.html", hide: hide)
  end

  def edit(conn, %{"id" => id}) do
    hide = Filters.get_hide!(id)
    changeset = Filters.change_hide(hide)
    render(conn, "edit.html", hide: hide, changeset: changeset)
  end

  def update(conn, %{"id" => id, "hide" => hide_params}) do
    hide = Filters.get_hide!(id)

    case Filters.update_hide(hide, hide_params) do
      {:ok, hide} ->
        conn
        |> put_flash(:info, "Hide updated successfully.")
        |> redirect(to: Routes.filters_hide_path(conn, :show, hide))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", hide: hide, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    hide = Filters.get_hide!(id)
    {:ok, _hide} = Filters.delete_hide(hide)

    conn
    |> put_flash(:info, "Hide deleted successfully.")
    |> redirect(to: Routes.filters_hide_path(conn, :index))
  end
end
