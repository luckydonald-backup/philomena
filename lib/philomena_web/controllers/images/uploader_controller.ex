defmodule PhilomenaWeb.Images.UploaderController do
  use PhilomenaWeb, :controller

  alias Philomena.Images
  alias Philomena.Images.Uploader

  def index(conn, _params) do
    uploader = Images.list_uploader()
    render(conn, "index.html", uploader: uploader)
  end

  def new(conn, _params) do
    changeset = Images.change_uploader(%Uploader{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"uploader" => uploader_params}) do
    case Images.create_uploader(uploader_params) do
      {:ok, uploader} ->
        conn
        |> put_flash(:info, "Uploader created successfully.")
        |> redirect(to: Routes.images_uploader_path(conn, :show, uploader))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    uploader = Images.get_uploader!(id)
    render(conn, "show.html", uploader: uploader)
  end

  def edit(conn, %{"id" => id}) do
    uploader = Images.get_uploader!(id)
    changeset = Images.change_uploader(uploader)
    render(conn, "edit.html", uploader: uploader, changeset: changeset)
  end

  def update(conn, %{"id" => id, "uploader" => uploader_params}) do
    uploader = Images.get_uploader!(id)

    case Images.update_uploader(uploader, uploader_params) do
      {:ok, uploader} ->
        conn
        |> put_flash(:info, "Uploader updated successfully.")
        |> redirect(to: Routes.images_uploader_path(conn, :show, uploader))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", uploader: uploader, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    uploader = Images.get_uploader!(id)
    {:ok, _uploader} = Images.delete_uploader(uploader)

    conn
    |> put_flash(:info, "Uploader deleted successfully.")
    |> redirect(to: Routes.images_uploader_path(conn, :index))
  end
end
