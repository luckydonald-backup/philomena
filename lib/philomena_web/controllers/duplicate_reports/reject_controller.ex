defmodule PhilomenaWeb.DuplicateReports.RejectController do
  use PhilomenaWeb, :controller

  alias Philomena.DuplicateReports
  alias Philomena.DuplicateReports.Reject

  def index(conn, _params) do
    reject = DuplicateReports.list_reject()
    render(conn, "index.html", reject: reject)
  end

  def new(conn, _params) do
    changeset = DuplicateReports.change_reject(%Reject{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"reject" => reject_params}) do
    case DuplicateReports.create_reject(reject_params) do
      {:ok, reject} ->
        conn
        |> put_flash(:info, "Reject created successfully.")
        |> redirect(to: Routes.duplicate_reports_reject_path(conn, :show, reject))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    reject = DuplicateReports.get_reject!(id)
    render(conn, "show.html", reject: reject)
  end

  def edit(conn, %{"id" => id}) do
    reject = DuplicateReports.get_reject!(id)
    changeset = DuplicateReports.change_reject(reject)
    render(conn, "edit.html", reject: reject, changeset: changeset)
  end

  def update(conn, %{"id" => id, "reject" => reject_params}) do
    reject = DuplicateReports.get_reject!(id)

    case DuplicateReports.update_reject(reject, reject_params) do
      {:ok, reject} ->
        conn
        |> put_flash(:info, "Reject updated successfully.")
        |> redirect(to: Routes.duplicate_reports_reject_path(conn, :show, reject))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", reject: reject, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    reject = DuplicateReports.get_reject!(id)
    {:ok, _reject} = DuplicateReports.delete_reject(reject)

    conn
    |> put_flash(:info, "Reject deleted successfully.")
    |> redirect(to: Routes.duplicate_reports_reject_path(conn, :index))
  end
end
