defmodule PhilomenaWeb.DuplicateReports.AcceptReverseController do
  use PhilomenaWeb, :controller

  alias Philomena.DuplicateReports
  alias Philomena.DuplicateReports.AcceptReverse

  def index(conn, _params) do
    accept_reverse = DuplicateReports.list_accept_reverse()
    render(conn, "index.html", accept_reverse: accept_reverse)
  end

  def new(conn, _params) do
    changeset = DuplicateReports.change_accept_reverse(%AcceptReverse{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"accept_reverse" => accept_reverse_params}) do
    case DuplicateReports.create_accept_reverse(accept_reverse_params) do
      {:ok, accept_reverse} ->
        conn
        |> put_flash(:info, "Accept reverse created successfully.")
        |> redirect(to: Routes.duplicate_reports_accept_reverse_path(conn, :show, accept_reverse))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    accept_reverse = DuplicateReports.get_accept_reverse!(id)
    render(conn, "show.html", accept_reverse: accept_reverse)
  end

  def edit(conn, %{"id" => id}) do
    accept_reverse = DuplicateReports.get_accept_reverse!(id)
    changeset = DuplicateReports.change_accept_reverse(accept_reverse)
    render(conn, "edit.html", accept_reverse: accept_reverse, changeset: changeset)
  end

  def update(conn, %{"id" => id, "accept_reverse" => accept_reverse_params}) do
    accept_reverse = DuplicateReports.get_accept_reverse!(id)

    case DuplicateReports.update_accept_reverse(accept_reverse, accept_reverse_params) do
      {:ok, accept_reverse} ->
        conn
        |> put_flash(:info, "Accept reverse updated successfully.")
        |> redirect(to: Routes.duplicate_reports_accept_reverse_path(conn, :show, accept_reverse))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", accept_reverse: accept_reverse, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    accept_reverse = DuplicateReports.get_accept_reverse!(id)
    {:ok, _accept_reverse} = DuplicateReports.delete_accept_reverse(accept_reverse)

    conn
    |> put_flash(:info, "Accept reverse deleted successfully.")
    |> redirect(to: Routes.duplicate_reports_accept_reverse_path(conn, :index))
  end
end
