defmodule PhilomenaWeb.Admin.Reports.CloseController do
  use PhilomenaWeb, :controller

  alias Philomena.Reports
  alias Philomena.Reports.Close

  def index(conn, _params) do
    reports = Reports.list_reports()
    render(conn, "index.html", reports: reports)
  end

  def new(conn, _params) do
    changeset = Reports.change_close(%Close{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"close" => close_params}) do
    case Reports.create_close(close_params) do
      {:ok, close} ->
        conn
        |> put_flash(:info, "Close created successfully.")
        |> redirect(to: Routes.admin_reports_close_path(conn, :show, close))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    close = Reports.get_close!(id)
    render(conn, "show.html", close: close)
  end

  def edit(conn, %{"id" => id}) do
    close = Reports.get_close!(id)
    changeset = Reports.change_close(close)
    render(conn, "edit.html", close: close, changeset: changeset)
  end

  def update(conn, %{"id" => id, "close" => close_params}) do
    close = Reports.get_close!(id)

    case Reports.update_close(close, close_params) do
      {:ok, close} ->
        conn
        |> put_flash(:info, "Close updated successfully.")
        |> redirect(to: Routes.admin_reports_close_path(conn, :show, close))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", close: close, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    close = Reports.get_close!(id)
    {:ok, _close} = Reports.delete_close(close)

    conn
    |> put_flash(:info, "Close deleted successfully.")
    |> redirect(to: Routes.admin_reports_close_path(conn, :index))
  end
end
