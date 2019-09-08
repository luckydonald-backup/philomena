defmodule PhilomenaWeb.Conversations.MessageController do
  use PhilomenaWeb, :controller

  alias Philomena.Conversations
  alias Philomena.Conversations.Message

  def index(conn, _params) do
    messages = Conversations.list_messages()
    render(conn, "index.html", messages: messages)
  end

  def new(conn, _params) do
    changeset = Conversations.change_message(%Message{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"message" => message_params}) do
    case Conversations.create_message(message_params) do
      {:ok, message} ->
        conn
        |> put_flash(:info, "Message created successfully.")
        |> redirect(to: Routes.conversations_message_path(conn, :show, message))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    message = Conversations.get_message!(id)
    render(conn, "show.html", message: message)
  end

  def edit(conn, %{"id" => id}) do
    message = Conversations.get_message!(id)
    changeset = Conversations.change_message(message)
    render(conn, "edit.html", message: message, changeset: changeset)
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Conversations.get_message!(id)

    case Conversations.update_message(message, message_params) do
      {:ok, message} ->
        conn
        |> put_flash(:info, "Message updated successfully.")
        |> redirect(to: Routes.conversations_message_path(conn, :show, message))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", message: message, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Conversations.get_message!(id)
    {:ok, _message} = Conversations.delete_message(message)

    conn
    |> put_flash(:info, "Message deleted successfully.")
    |> redirect(to: Routes.conversations_message_path(conn, :index))
  end
end
