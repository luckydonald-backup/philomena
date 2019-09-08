defmodule PhilomenaWeb.Tags.UsageController do
  use PhilomenaWeb, :controller

  alias Philomena.Tags
  alias Philomena.Tags.Usage

  def index(conn, _params) do
    usage = Tags.list_usage()
    render(conn, "index.html", usage: usage)
  end

  def new(conn, _params) do
    changeset = Tags.change_usage(%Usage{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"usage" => usage_params}) do
    case Tags.create_usage(usage_params) do
      {:ok, usage} ->
        conn
        |> put_flash(:info, "Usage created successfully.")
        |> redirect(to: Routes.tags_usage_path(conn, :show, usage))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    usage = Tags.get_usage!(id)
    render(conn, "show.html", usage: usage)
  end

  def edit(conn, %{"id" => id}) do
    usage = Tags.get_usage!(id)
    changeset = Tags.change_usage(usage)
    render(conn, "edit.html", usage: usage, changeset: changeset)
  end

  def update(conn, %{"id" => id, "usage" => usage_params}) do
    usage = Tags.get_usage!(id)

    case Tags.update_usage(usage, usage_params) do
      {:ok, usage} ->
        conn
        |> put_flash(:info, "Usage updated successfully.")
        |> redirect(to: Routes.tags_usage_path(conn, :show, usage))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", usage: usage, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    usage = Tags.get_usage!(id)
    {:ok, _usage} = Tags.delete_usage(usage)

    conn
    |> put_flash(:info, "Usage deleted successfully.")
    |> redirect(to: Routes.tags_usage_path(conn, :index))
  end
end
