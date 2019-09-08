defmodule PhilomenaWeb.Images.PreviewController do
  use PhilomenaWeb, :controller

  alias Philomena.Images
  alias Philomena.Images.Preview

  def index(conn, _params) do
    image_previews = Images.list_image_previews()
    render(conn, "index.html", image_previews: image_previews)
  end

  def new(conn, _params) do
    changeset = Images.change_preview(%Preview{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"preview" => preview_params}) do
    case Images.create_preview(preview_params) do
      {:ok, preview} ->
        conn
        |> put_flash(:info, "Preview created successfully.")
        |> redirect(to: Routes.images_preview_path(conn, :show, preview))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    preview = Images.get_preview!(id)
    render(conn, "show.html", preview: preview)
  end

  def edit(conn, %{"id" => id}) do
    preview = Images.get_preview!(id)
    changeset = Images.change_preview(preview)
    render(conn, "edit.html", preview: preview, changeset: changeset)
  end

  def update(conn, %{"id" => id, "preview" => preview_params}) do
    preview = Images.get_preview!(id)

    case Images.update_preview(preview, preview_params) do
      {:ok, preview} ->
        conn
        |> put_flash(:info, "Preview updated successfully.")
        |> redirect(to: Routes.images_preview_path(conn, :show, preview))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", preview: preview, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    preview = Images.get_preview!(id)
    {:ok, _preview} = Images.delete_preview(preview)

    conn
    |> put_flash(:info, "Preview deleted successfully.")
    |> redirect(to: Routes.images_preview_path(conn, :index))
  end
end
