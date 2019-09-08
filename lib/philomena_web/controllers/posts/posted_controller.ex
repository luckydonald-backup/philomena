defmodule PhilomenaWeb.Posts.PostedController do
  use PhilomenaWeb, :controller

  alias Philomena.Posts
  alias Philomena.Posts.Posted

  def index(conn, _params) do
    posted = Posts.list_posted()
    render(conn, "index.html", posted: posted)
  end

  def new(conn, _params) do
    changeset = Posts.change_posted(%Posted{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"posted" => posted_params}) do
    case Posts.create_posted(posted_params) do
      {:ok, posted} ->
        conn
        |> put_flash(:info, "Posted created successfully.")
        |> redirect(to: Routes.posts_posted_path(conn, :show, posted))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    posted = Posts.get_posted!(id)
    render(conn, "show.html", posted: posted)
  end

  def edit(conn, %{"id" => id}) do
    posted = Posts.get_posted!(id)
    changeset = Posts.change_posted(posted)
    render(conn, "edit.html", posted: posted, changeset: changeset)
  end

  def update(conn, %{"id" => id, "posted" => posted_params}) do
    posted = Posts.get_posted!(id)

    case Posts.update_posted(posted, posted_params) do
      {:ok, posted} ->
        conn
        |> put_flash(:info, "Posted updated successfully.")
        |> redirect(to: Routes.posts_posted_path(conn, :show, posted))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", posted: posted, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    posted = Posts.get_posted!(id)
    {:ok, _posted} = Posts.delete_posted(posted)

    conn
    |> put_flash(:info, "Posted deleted successfully.")
    |> redirect(to: Routes.posts_posted_path(conn, :index))
  end
end
