defmodule PhilomenaWeb.Admin.ReportController do
  use PhilomenaWeb, :controller

  alias Philomena.Reports
  alias Philomena.Reports.Report

  def index(conn, _params) do
    reports = Reports.list_reports()
    render(conn, "index.html", reports: reports)
  end

  def new(conn, _params) do
    changeset = Reports.change_report(%Report{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"report" => report_params}) do
    case Reports.create_report(report_params) do
      {:ok, report} ->
        conn
        |> put_flash(:info, "Report created successfully.")
        |> redirect(to: Routes.admin_report_path(conn, :show, report))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    report = Reports.get_report!(id)
    render(conn, "show.html", report: report)
  end

  def edit(conn, %{"id" => id}) do
    report = Reports.get_report!(id)
    changeset = Reports.change_report(report)
    render(conn, "edit.html", report: report, changeset: changeset)
  end

  def update(conn, %{"id" => id, "report" => report_params}) do
    report = Reports.get_report!(id)

    case Reports.update_report(report, report_params) do
      {:ok, report} ->
        conn
        |> put_flash(:info, "Report updated successfully.")
        |> redirect(to: Routes.admin_report_path(conn, :show, report))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", report: report, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    report = Reports.get_report!(id)
    {:ok, _report} = Reports.delete_report(report)

    conn
    |> put_flash(:info, "Report deleted successfully.")
    |> redirect(to: Routes.admin_report_path(conn, :index))
  end
end
