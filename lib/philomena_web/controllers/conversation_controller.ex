defmodule PhilomenaWeb.ConversationController do
  use PhilomenaWeb, :controller

  alias Philomena.Conversations
  alias Philomena.Conversations.Conversation

  def index(conn, _params) do
    conversations = Conversations.list_conversations()
    render(conn, "index.html", conversations: conversations)
  end

  def new(conn, _params) do
    changeset = Conversations.change_conversation(%Conversation{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"conversation" => conversation_params}) do
    case Conversations.create_conversation(conversation_params) do
      {:ok, conversation} ->
        conn
        |> put_flash(:info, "Conversation created successfully.")
        |> redirect(to: Routes.conversation_path(conn, :show, conversation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    conversation = Conversations.get_conversation!(id)
    render(conn, "show.html", conversation: conversation)
  end

  def edit(conn, %{"id" => id}) do
    conversation = Conversations.get_conversation!(id)
    changeset = Conversations.change_conversation(conversation)
    render(conn, "edit.html", conversation: conversation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "conversation" => conversation_params}) do
    conversation = Conversations.get_conversation!(id)

    case Conversations.update_conversation(conversation, conversation_params) do
      {:ok, conversation} ->
        conn
        |> put_flash(:info, "Conversation updated successfully.")
        |> redirect(to: Routes.conversation_path(conn, :show, conversation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", conversation: conversation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    conversation = Conversations.get_conversation!(id)
    {:ok, _conversation} = Conversations.delete_conversation(conversation)

    conn
    |> put_flash(:info, "Conversation deleted successfully.")
    |> redirect(to: Routes.conversation_path(conn, :index))
  end
end
