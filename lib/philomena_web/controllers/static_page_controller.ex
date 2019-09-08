defmodule PhilomenaWeb.StaticPageController do
  use PhilomenaWeb, :controller

  alias Philomena.StaticPages
  alias Philomena.StaticPages.StaticPage

  def index(conn, _params) do
    static_pages = StaticPages.list_static_pages()
    render(conn, "index.html", static_pages: static_pages)
  end

  def new(conn, _params) do
    changeset = StaticPages.change_static_page(%StaticPage{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"static_page" => static_page_params}) do
    case StaticPages.create_static_page(static_page_params) do
      {:ok, static_page} ->
        conn
        |> put_flash(:info, "Static page created successfully.")
        |> redirect(to: Routes.static_page_path(conn, :show, static_page))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    static_page = StaticPages.get_static_page!(id)
    render(conn, "show.html", static_page: static_page)
  end

  def edit(conn, %{"id" => id}) do
    static_page = StaticPages.get_static_page!(id)
    changeset = StaticPages.change_static_page(static_page)
    render(conn, "edit.html", static_page: static_page, changeset: changeset)
  end

  def update(conn, %{"id" => id, "static_page" => static_page_params}) do
    static_page = StaticPages.get_static_page!(id)

    case StaticPages.update_static_page(static_page, static_page_params) do
      {:ok, static_page} ->
        conn
        |> put_flash(:info, "Static page updated successfully.")
        |> redirect(to: Routes.static_page_path(conn, :show, static_page))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", static_page: static_page, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    static_page = StaticPages.get_static_page!(id)
    {:ok, _static_page} = StaticPages.delete_static_page(static_page)

    conn
    |> put_flash(:info, "Static page deleted successfully.")
    |> redirect(to: Routes.static_page_path(conn, :index))
  end
end
