defmodule PhilomenaWeb.Stats.ChartController do
  use PhilomenaWeb, :controller

  alias Philomena.Stats
  alias Philomena.Stats.Chart

  def index(conn, _params) do
    chart = Stats.list_chart()
    render(conn, "index.html", chart: chart)
  end

  def new(conn, _params) do
    changeset = Stats.change_chart(%Chart{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"chart" => chart_params}) do
    case Stats.create_chart(chart_params) do
      {:ok, chart} ->
        conn
        |> put_flash(:info, "Chart created successfully.")
        |> redirect(to: Routes.stats_chart_path(conn, :show, chart))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    chart = Stats.get_chart!(id)
    render(conn, "show.html", chart: chart)
  end

  def edit(conn, %{"id" => id}) do
    chart = Stats.get_chart!(id)
    changeset = Stats.change_chart(chart)
    render(conn, "edit.html", chart: chart, changeset: changeset)
  end

  def update(conn, %{"id" => id, "chart" => chart_params}) do
    chart = Stats.get_chart!(id)

    case Stats.update_chart(chart, chart_params) do
      {:ok, chart} ->
        conn
        |> put_flash(:info, "Chart updated successfully.")
        |> redirect(to: Routes.stats_chart_path(conn, :show, chart))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", chart: chart, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    chart = Stats.get_chart!(id)
    {:ok, _chart} = Stats.delete_chart(chart)

    conn
    |> put_flash(:info, "Chart deleted successfully.")
    |> redirect(to: Routes.stats_chart_path(conn, :index))
  end
end
