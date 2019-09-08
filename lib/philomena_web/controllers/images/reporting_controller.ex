defmodule PhilomenaWeb.Images.ReportingController do
  use PhilomenaWeb, :controller

  alias Philomena.Images
  alias Philomena.Images.Reporting

  def index(conn, _params) do
    reporting = Images.list_reporting()
    render(conn, "index.html", reporting: reporting)
  end

  def new(conn, _params) do
    changeset = Images.change_reporting(%Reporting{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"reporting" => reporting_params}) do
    case Images.create_reporting(reporting_params) do
      {:ok, reporting} ->
        conn
        |> put_flash(:info, "Reporting created successfully.")
        |> redirect(to: Routes.images_reporting_path(conn, :show, reporting))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    reporting = Images.get_reporting!(id)
    render(conn, "show.html", reporting: reporting)
  end

  def edit(conn, %{"id" => id}) do
    reporting = Images.get_reporting!(id)
    changeset = Images.change_reporting(reporting)
    render(conn, "edit.html", reporting: reporting, changeset: changeset)
  end

  def update(conn, %{"id" => id, "reporting" => reporting_params}) do
    reporting = Images.get_reporting!(id)

    case Images.update_reporting(reporting, reporting_params) do
      {:ok, reporting} ->
        conn
        |> put_flash(:info, "Reporting updated successfully.")
        |> redirect(to: Routes.images_reporting_path(conn, :show, reporting))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", reporting: reporting, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    reporting = Images.get_reporting!(id)
    {:ok, _reporting} = Images.delete_reporting(reporting)

    conn
    |> put_flash(:info, "Reporting deleted successfully.")
    |> redirect(to: Routes.images_reporting_path(conn, :index))
  end
end
