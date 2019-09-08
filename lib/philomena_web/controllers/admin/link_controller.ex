defmodule PhilomenaWeb.Admin.LinkController do
  use PhilomenaWeb, :controller

  alias Philomena.Users
  alias Philomena.Users.Link

  def index(conn, _params) do
    user_links = Users.list_user_links()
    render(conn, "index.html", user_links: user_links)
  end

  def new(conn, _params) do
    changeset = Users.change_link(%Link{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"link" => link_params}) do
    case Users.create_link(link_params) do
      {:ok, link} ->
        conn
        |> put_flash(:info, "Link created successfully.")
        |> redirect(to: Routes.admin_link_path(conn, :show, link))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    link = Users.get_link!(id)
    render(conn, "show.html", link: link)
  end

  def edit(conn, %{"id" => id}) do
    link = Users.get_link!(id)
    changeset = Users.change_link(link)
    render(conn, "edit.html", link: link, changeset: changeset)
  end

  def update(conn, %{"id" => id, "link" => link_params}) do
    link = Users.get_link!(id)

    case Users.update_link(link, link_params) do
      {:ok, link} ->
        conn
        |> put_flash(:info, "Link updated successfully.")
        |> redirect(to: Routes.admin_link_path(conn, :show, link))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", link: link, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    link = Users.get_link!(id)
    {:ok, _link} = Users.delete_link(link)

    conn
    |> put_flash(:info, "Link deleted successfully.")
    |> redirect(to: Routes.admin_link_path(conn, :index))
  end
end
