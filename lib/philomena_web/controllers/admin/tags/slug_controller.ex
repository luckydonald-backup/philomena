defmodule PhilomenaWeb.Admin.Tags.SlugController do
  use PhilomenaWeb, :controller

  alias Philomena.Tags
  alias Philomena.Tags.Slug

  def index(conn, _params) do
    tags = Tags.list_tags()
    render(conn, "index.html", tags: tags)
  end

  def new(conn, _params) do
    changeset = Tags.change_slug(%Slug{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"slug" => slug_params}) do
    case Tags.create_slug(slug_params) do
      {:ok, slug} ->
        conn
        |> put_flash(:info, "Slug created successfully.")
        |> redirect(to: Routes.admin_tags_slug_path(conn, :show, slug))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    slug = Tags.get_slug!(id)
    render(conn, "show.html", slug: slug)
  end

  def edit(conn, %{"id" => id}) do
    slug = Tags.get_slug!(id)
    changeset = Tags.change_slug(slug)
    render(conn, "edit.html", slug: slug, changeset: changeset)
  end

  def update(conn, %{"id" => id, "slug" => slug_params}) do
    slug = Tags.get_slug!(id)

    case Tags.update_slug(slug, slug_params) do
      {:ok, slug} ->
        conn
        |> put_flash(:info, "Slug updated successfully.")
        |> redirect(to: Routes.admin_tags_slug_path(conn, :show, slug))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", slug: slug, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    slug = Tags.get_slug!(id)
    {:ok, _slug} = Tags.delete_slug(slug)

    conn
    |> put_flash(:info, "Slug deleted successfully.")
    |> redirect(to: Routes.admin_tags_slug_path(conn, :index))
  end
end
