defmodule PhilomenaWeb.Conversations.ReadController do
  use PhilomenaWeb, :controller

  alias Philomena.Conversations
  alias Philomena.Conversations.Read

  def index(conn, _params) do
    read = Conversations.list_read()
    render(conn, "index.html", read: read)
  end

  def new(conn, _params) do
    changeset = Conversations.change_read(%Read{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"read" => read_params}) do
    case Conversations.create_read(read_params) do
      {:ok, read} ->
        conn
        |> put_flash(:info, "Read created successfully.")
        |> redirect(to: Routes.conversations_read_path(conn, :show, read))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    read = Conversations.get_read!(id)
    render(conn, "show.html", read: read)
  end

  def edit(conn, %{"id" => id}) do
    read = Conversations.get_read!(id)
    changeset = Conversations.change_read(read)
    render(conn, "edit.html", read: read, changeset: changeset)
  end

  def update(conn, %{"id" => id, "read" => read_params}) do
    read = Conversations.get_read!(id)

    case Conversations.update_read(read, read_params) do
      {:ok, read} ->
        conn
        |> put_flash(:info, "Read updated successfully.")
        |> redirect(to: Routes.conversations_read_path(conn, :show, read))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", read: read, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    read = Conversations.get_read!(id)
    {:ok, _read} = Conversations.delete_read(read)

    conn
    |> put_flash(:info, "Read deleted successfully.")
    |> redirect(to: Routes.conversations_read_path(conn, :index))
  end
end
