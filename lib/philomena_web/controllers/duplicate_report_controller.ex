defmodule PhilomenaWeb.DuplicateReportController do
  use PhilomenaWeb, :controller

  alias Philomena.DuplicateReports
  alias Philomena.DuplicateReports.DuplicateReport

  def index(conn, _params) do
    duplicate_reports = DuplicateReports.list_duplicate_reports()
    render(conn, "index.html", duplicate_reports: duplicate_reports)
  end

  def new(conn, _params) do
    changeset = DuplicateReports.change_duplicate_report(%DuplicateReport{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"duplicate_report" => duplicate_report_params}) do
    case DuplicateReports.create_duplicate_report(duplicate_report_params) do
      {:ok, duplicate_report} ->
        conn
        |> put_flash(:info, "Duplicate report created successfully.")
        |> redirect(to: Routes.duplicate_report_path(conn, :show, duplicate_report))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    duplicate_report = DuplicateReports.get_duplicate_report!(id)
    render(conn, "show.html", duplicate_report: duplicate_report)
  end

  def edit(conn, %{"id" => id}) do
    duplicate_report = DuplicateReports.get_duplicate_report!(id)
    changeset = DuplicateReports.change_duplicate_report(duplicate_report)
    render(conn, "edit.html", duplicate_report: duplicate_report, changeset: changeset)
  end

  def update(conn, %{"id" => id, "duplicate_report" => duplicate_report_params}) do
    duplicate_report = DuplicateReports.get_duplicate_report!(id)

    case DuplicateReports.update_duplicate_report(duplicate_report, duplicate_report_params) do
      {:ok, duplicate_report} ->
        conn
        |> put_flash(:info, "Duplicate report updated successfully.")
        |> redirect(to: Routes.duplicate_report_path(conn, :show, duplicate_report))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", duplicate_report: duplicate_report, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    duplicate_report = DuplicateReports.get_duplicate_report!(id)
    {:ok, _duplicate_report} = DuplicateReports.delete_duplicate_report(duplicate_report)

    conn
    |> put_flash(:info, "Duplicate report deleted successfully.")
    |> redirect(to: Routes.duplicate_report_path(conn, :index))
  end
end
