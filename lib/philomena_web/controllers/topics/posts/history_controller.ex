defmodule PhilomenaWeb.Topics.Posts.HistoryController do
  use PhilomenaWeb, :controller

  alias Philomena.Topics
  alias Philomena.Topics.History

  def index(conn, _params) do
    histories = Topics.list_histories()
    render(conn, "index.html", histories: histories)
  end

  def new(conn, _params) do
    changeset = Topics.change_history(%History{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"history" => history_params}) do
    case Topics.create_history(history_params) do
      {:ok, history} ->
        conn
        |> put_flash(:info, "History created successfully.")
        |> redirect(to: Routes.topics_posts_history_path(conn, :show, history))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    history = Topics.get_history!(id)
    render(conn, "show.html", history: history)
  end

  def edit(conn, %{"id" => id}) do
    history = Topics.get_history!(id)
    changeset = Topics.change_history(history)
    render(conn, "edit.html", history: history, changeset: changeset)
  end

  def update(conn, %{"id" => id, "history" => history_params}) do
    history = Topics.get_history!(id)

    case Topics.update_history(history, history_params) do
      {:ok, history} ->
        conn
        |> put_flash(:info, "History updated successfully.")
        |> redirect(to: Routes.topics_posts_history_path(conn, :show, history))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", history: history, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    history = Topics.get_history!(id)
    {:ok, _history} = Topics.delete_history(history)

    conn
    |> put_flash(:info, "History deleted successfully.")
    |> redirect(to: Routes.topics_posts_history_path(conn, :index))
  end
end
