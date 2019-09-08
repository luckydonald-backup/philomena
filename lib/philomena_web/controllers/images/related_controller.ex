defmodule PhilomenaWeb.Images.RelatedController do
  use PhilomenaWeb, :controller

  alias Philomena.Images
  alias Philomena.Images.Related

  def index(conn, _params) do
    relateds = Images.list_relateds()
    render(conn, "index.html", relateds: relateds)
  end

  def new(conn, _params) do
    changeset = Images.change_related(%Related{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"related" => related_params}) do
    case Images.create_related(related_params) do
      {:ok, related} ->
        conn
        |> put_flash(:info, "Related created successfully.")
        |> redirect(to: Routes.images_related_path(conn, :show, related))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    related = Images.get_related!(id)
    render(conn, "show.html", related: related)
  end

  def edit(conn, %{"id" => id}) do
    related = Images.get_related!(id)
    changeset = Images.change_related(related)
    render(conn, "edit.html", related: related, changeset: changeset)
  end

  def update(conn, %{"id" => id, "related" => related_params}) do
    related = Images.get_related!(id)

    case Images.update_related(related, related_params) do
      {:ok, related} ->
        conn
        |> put_flash(:info, "Related updated successfully.")
        |> redirect(to: Routes.images_related_path(conn, :show, related))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", related: related, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    related = Images.get_related!(id)
    {:ok, _related} = Images.delete_related(related)

    conn
    |> put_flash(:info, "Related deleted successfully.")
    |> redirect(to: Routes.images_related_path(conn, :index))
  end
end
