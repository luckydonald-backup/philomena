defmodule PhilomenaWeb.DuplicateReports.AcceptController do
  use PhilomenaWeb, :controller

  alias Philomena.DuplicateReports
  alias Philomena.DuplicateReports.Accept

  def index(conn, _params) do
    accept = DuplicateReports.list_accept()
    render(conn, "index.html", accept: accept)
  end

  def new(conn, _params) do
    changeset = DuplicateReports.change_accept(%Accept{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"accept" => accept_params}) do
    case DuplicateReports.create_accept(accept_params) do
      {:ok, accept} ->
        conn
        |> put_flash(:info, "Accept created successfully.")
        |> redirect(to: Routes.duplicate_reports_accept_path(conn, :show, accept))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    accept = DuplicateReports.get_accept!(id)
    render(conn, "show.html", accept: accept)
  end

  def edit(conn, %{"id" => id}) do
    accept = DuplicateReports.get_accept!(id)
    changeset = DuplicateReports.change_accept(accept)
    render(conn, "edit.html", accept: accept, changeset: changeset)
  end

  def update(conn, %{"id" => id, "accept" => accept_params}) do
    accept = DuplicateReports.get_accept!(id)

    case DuplicateReports.update_accept(accept, accept_params) do
      {:ok, accept} ->
        conn
        |> put_flash(:info, "Accept updated successfully.")
        |> redirect(to: Routes.duplicate_reports_accept_path(conn, :show, accept))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", accept: accept, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    accept = DuplicateReports.get_accept!(id)
    {:ok, _accept} = DuplicateReports.delete_accept(accept)

    conn
    |> put_flash(:info, "Accept deleted successfully.")
    |> redirect(to: Routes.duplicate_reports_accept_path(conn, :index))
  end
end
