defmodule PhilomenaWeb.Images.FileController do
  use PhilomenaWeb, :controller

  alias Philomena.Images
  alias Philomena.Images.File

  def index(conn, _params) do
    image_files = Images.list_image_files()
    render(conn, "index.html", image_files: image_files)
  end

  def new(conn, _params) do
    changeset = Images.change_file(%File{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"file" => file_params}) do
    case Images.create_file(file_params) do
      {:ok, file} ->
        conn
        |> put_flash(:info, "File created successfully.")
        |> redirect(to: Routes.images_file_path(conn, :show, file))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    file = Images.get_file!(id)
    render(conn, "show.html", file: file)
  end

  def edit(conn, %{"id" => id}) do
    file = Images.get_file!(id)
    changeset = Images.change_file(file)
    render(conn, "edit.html", file: file, changeset: changeset)
  end

  def update(conn, %{"id" => id, "file" => file_params}) do
    file = Images.get_file!(id)

    case Images.update_file(file, file_params) do
      {:ok, file} ->
        conn
        |> put_flash(:info, "File updated successfully.")
        |> redirect(to: Routes.images_file_path(conn, :show, file))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", file: file, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    file = Images.get_file!(id)
    {:ok, _file} = Images.delete_file(file)

    conn
    |> put_flash(:info, "File deleted successfully.")
    |> redirect(to: Routes.images_file_path(conn, :index))
  end
end
