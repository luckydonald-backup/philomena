defmodule PhilomenaWeb.UserLinkController do
  use PhilomenaWeb, :controller

  alias Philomena.UserLinks
  alias Philomena.UserLinks.UserLink

  def index(conn, _params) do
    user_links = UserLinks.list_user_links()
    render(conn, "index.html", user_links: user_links)
  end

  def new(conn, _params) do
    changeset = UserLinks.change_user_link(%UserLink{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user_link" => user_link_params}) do
    case UserLinks.create_user_link(user_link_params) do
      {:ok, user_link} ->
        conn
        |> put_flash(:info, "User link created successfully.")
        |> redirect(to: Routes.user_link_path(conn, :show, user_link))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_link = UserLinks.get_user_link!(id)
    render(conn, "show.html", user_link: user_link)
  end

  def edit(conn, %{"id" => id}) do
    user_link = UserLinks.get_user_link!(id)
    changeset = UserLinks.change_user_link(user_link)
    render(conn, "edit.html", user_link: user_link, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user_link" => user_link_params}) do
    user_link = UserLinks.get_user_link!(id)

    case UserLinks.update_user_link(user_link, user_link_params) do
      {:ok, user_link} ->
        conn
        |> put_flash(:info, "User link updated successfully.")
        |> redirect(to: Routes.user_link_path(conn, :show, user_link))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user_link: user_link, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_link = UserLinks.get_user_link!(id)
    {:ok, _user_link} = UserLinks.delete_user_link(user_link)

    conn
    |> put_flash(:info, "User link deleted successfully.")
    |> redirect(to: Routes.user_link_path(conn, :index))
  end
end
