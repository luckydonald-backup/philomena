defmodule PhilomenaWeb.Conversations.HideController do
  use PhilomenaWeb, :controller

  alias Philomena.Conversations
  alias Philomena.Conversations.Hide

  def index(conn, _params) do
    hide = Conversations.list_hide()
    render(conn, "index.html", hide: hide)
  end

  def new(conn, _params) do
    changeset = Conversations.change_hide(%Hide{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"hide" => hide_params}) do
    case Conversations.create_hide(hide_params) do
      {:ok, hide} ->
        conn
        |> put_flash(:info, "Hide created successfully.")
        |> redirect(to: Routes.conversations_hide_path(conn, :show, hide))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    hide = Conversations.get_hide!(id)
    render(conn, "show.html", hide: hide)
  end

  def edit(conn, %{"id" => id}) do
    hide = Conversations.get_hide!(id)
    changeset = Conversations.change_hide(hide)
    render(conn, "edit.html", hide: hide, changeset: changeset)
  end

  def update(conn, %{"id" => id, "hide" => hide_params}) do
    hide = Conversations.get_hide!(id)

    case Conversations.update_hide(hide, hide_params) do
      {:ok, hide} ->
        conn
        |> put_flash(:info, "Hide updated successfully.")
        |> redirect(to: Routes.conversations_hide_path(conn, :show, hide))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", hide: hide, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    hide = Conversations.get_hide!(id)
    {:ok, _hide} = Conversations.delete_hide(hide)

    conn
    |> put_flash(:info, "Hide deleted successfully.")
    |> redirect(to: Routes.conversations_hide_path(conn, :index))
  end
end
