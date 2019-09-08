defmodule PhilomenaWeb.Images.SourceController do
  use PhilomenaWeb, :controller

  alias Philomena.Images
  alias Philomena.Images.Source

  def index(conn, _params) do
    sources = Images.list_sources()
    render(conn, "index.html", sources: sources)
  end

  def new(conn, _params) do
    changeset = Images.change_source(%Source{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"source" => source_params}) do
    case Images.create_source(source_params) do
      {:ok, source} ->
        conn
        |> put_flash(:info, "Source created successfully.")
        |> redirect(to: Routes.images_source_path(conn, :show, source))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    source = Images.get_source!(id)
    render(conn, "show.html", source: source)
  end

  def edit(conn, %{"id" => id}) do
    source = Images.get_source!(id)
    changeset = Images.change_source(source)
    render(conn, "edit.html", source: source, changeset: changeset)
  end

  def update(conn, %{"id" => id, "source" => source_params}) do
    source = Images.get_source!(id)

    case Images.update_source(source, source_params) do
      {:ok, source} ->
        conn
        |> put_flash(:info, "Source updated successfully.")
        |> redirect(to: Routes.images_source_path(conn, :show, source))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", source: source, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    source = Images.get_source!(id)
    {:ok, _source} = Images.delete_source(source)

    conn
    |> put_flash(:info, "Source deleted successfully.")
    |> redirect(to: Routes.images_source_path(conn, :index))
  end
end
