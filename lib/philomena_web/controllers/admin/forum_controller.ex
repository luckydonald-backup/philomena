defmodule PhilomenaWeb.Admin.ForumController do
  use PhilomenaWeb, :controller

  alias Philomena.Forums
  alias Philomena.Forums.Forum

  def index(conn, _params) do
    forums = Forums.list_forums()
    render(conn, "index.html", forums: forums)
  end

  def new(conn, _params) do
    changeset = Forums.change_forum(%Forum{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"forum" => forum_params}) do
    case Forums.create_forum(forum_params) do
      {:ok, forum} ->
        conn
        |> put_flash(:info, "Forum created successfully.")
        |> redirect(to: Routes.admin_forum_path(conn, :show, forum))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    forum = Forums.get_forum!(id)
    render(conn, "show.html", forum: forum)
  end

  def edit(conn, %{"id" => id}) do
    forum = Forums.get_forum!(id)
    changeset = Forums.change_forum(forum)
    render(conn, "edit.html", forum: forum, changeset: changeset)
  end

  def update(conn, %{"id" => id, "forum" => forum_params}) do
    forum = Forums.get_forum!(id)

    case Forums.update_forum(forum, forum_params) do
      {:ok, forum} ->
        conn
        |> put_flash(:info, "Forum updated successfully.")
        |> redirect(to: Routes.admin_forum_path(conn, :show, forum))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", forum: forum, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    forum = Forums.get_forum!(id)
    {:ok, _forum} = Forums.delete_forum(forum)

    conn
    |> put_flash(:info, "Forum deleted successfully.")
    |> redirect(to: Routes.admin_forum_path(conn, :index))
  end
end
