defmodule PhilomenaWeb.Images.Comments.HistoryController do
  use PhilomenaWeb, :controller

  alias Philomena.Comments
  alias Philomena.Comments.History

  def index(conn, _params) do
    history = Comments.list_history()
    render(conn, "index.html", history: history)
  end

  def new(conn, _params) do
    changeset = Comments.change_history(%History{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"history" => history_params}) do
    case Comments.create_history(history_params) do
      {:ok, history} ->
        conn
        |> put_flash(:info, "History created successfully.")
        |> redirect(to: Routes.images_comments_history_path(conn, :show, history))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    history = Comments.get_history!(id)
    render(conn, "show.html", history: history)
  end

  def edit(conn, %{"id" => id}) do
    history = Comments.get_history!(id)
    changeset = Comments.change_history(history)
    render(conn, "edit.html", history: history, changeset: changeset)
  end

  def update(conn, %{"id" => id, "history" => history_params}) do
    history = Comments.get_history!(id)

    case Comments.update_history(history, history_params) do
      {:ok, history} ->
        conn
        |> put_flash(:info, "History updated successfully.")
        |> redirect(to: Routes.images_comments_history_path(conn, :show, history))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", history: history, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    history = Comments.get_history!(id)
    {:ok, _history} = Comments.delete_history(history)

    conn
    |> put_flash(:info, "History deleted successfully.")
    |> redirect(to: Routes.images_comments_history_path(conn, :index))
  end
end
