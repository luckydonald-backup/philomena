defmodule PhilomenaWeb.Conversations.HideBatchController do
  use PhilomenaWeb, :controller

  alias Philomena.Conversations
  alias Philomena.Conversations.HideBatch

  def index(conn, _params) do
    hide_batch = Conversations.list_hide_batch()
    render(conn, "index.html", hide_batch: hide_batch)
  end

  def new(conn, _params) do
    changeset = Conversations.change_hide_batch(%HideBatch{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"hide_batch" => hide_batch_params}) do
    case Conversations.create_hide_batch(hide_batch_params) do
      {:ok, hide_batch} ->
        conn
        |> put_flash(:info, "Hide batch created successfully.")
        |> redirect(to: Routes.conversations_hide_batch_path(conn, :show, hide_batch))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    hide_batch = Conversations.get_hide_batch!(id)
    render(conn, "show.html", hide_batch: hide_batch)
  end

  def edit(conn, %{"id" => id}) do
    hide_batch = Conversations.get_hide_batch!(id)
    changeset = Conversations.change_hide_batch(hide_batch)
    render(conn, "edit.html", hide_batch: hide_batch, changeset: changeset)
  end

  def update(conn, %{"id" => id, "hide_batch" => hide_batch_params}) do
    hide_batch = Conversations.get_hide_batch!(id)

    case Conversations.update_hide_batch(hide_batch, hide_batch_params) do
      {:ok, hide_batch} ->
        conn
        |> put_flash(:info, "Hide batch updated successfully.")
        |> redirect(to: Routes.conversations_hide_batch_path(conn, :show, hide_batch))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", hide_batch: hide_batch, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    hide_batch = Conversations.get_hide_batch!(id)
    {:ok, _hide_batch} = Conversations.delete_hide_batch(hide_batch)

    conn
    |> put_flash(:info, "Hide batch deleted successfully.")
    |> redirect(to: Routes.conversations_hide_batch_path(conn, :index))
  end
end
