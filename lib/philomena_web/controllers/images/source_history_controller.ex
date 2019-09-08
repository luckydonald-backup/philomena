defmodule PhilomenaWeb.Images.SourceHistoryController do
  use PhilomenaWeb, :controller

  alias Philomena.Images
  alias Philomena.Images.SourceHistory

  def index(conn, _params) do
    source_histories = Images.list_source_histories()
    render(conn, "index.html", source_histories: source_histories)
  end

  def new(conn, _params) do
    changeset = Images.change_source_history(%SourceHistory{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"source_history" => source_history_params}) do
    case Images.create_source_history(source_history_params) do
      {:ok, source_history} ->
        conn
        |> put_flash(:info, "Source history created successfully.")
        |> redirect(to: Routes.images_source_history_path(conn, :show, source_history))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    source_history = Images.get_source_history!(id)
    render(conn, "show.html", source_history: source_history)
  end

  def edit(conn, %{"id" => id}) do
    source_history = Images.get_source_history!(id)
    changeset = Images.change_source_history(source_history)
    render(conn, "edit.html", source_history: source_history, changeset: changeset)
  end

  def update(conn, %{"id" => id, "source_history" => source_history_params}) do
    source_history = Images.get_source_history!(id)

    case Images.update_source_history(source_history, source_history_params) do
      {:ok, source_history} ->
        conn
        |> put_flash(:info, "Source history updated successfully.")
        |> redirect(to: Routes.images_source_history_path(conn, :show, source_history))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", source_history: source_history, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    source_history = Images.get_source_history!(id)
    {:ok, _source_history} = Images.delete_source_history(source_history)

    conn
    |> put_flash(:info, "Source history deleted successfully.")
    |> redirect(to: Routes.images_source_history_path(conn, :index))
  end
end
