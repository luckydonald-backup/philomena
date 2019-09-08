defmodule PhilomenaWeb.Images.DescriptionController do
  use PhilomenaWeb, :controller

  alias Philomena.Images
  alias Philomena.Images.Description

  def index(conn, _params) do
    descriptions = Images.list_descriptions()
    render(conn, "index.html", descriptions: descriptions)
  end

  def new(conn, _params) do
    changeset = Images.change_description(%Description{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"description" => description_params}) do
    case Images.create_description(description_params) do
      {:ok, description} ->
        conn
        |> put_flash(:info, "Description created successfully.")
        |> redirect(to: Routes.images_description_path(conn, :show, description))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    description = Images.get_description!(id)
    render(conn, "show.html", description: description)
  end

  def edit(conn, %{"id" => id}) do
    description = Images.get_description!(id)
    changeset = Images.change_description(description)
    render(conn, "edit.html", description: description, changeset: changeset)
  end

  def update(conn, %{"id" => id, "description" => description_params}) do
    description = Images.get_description!(id)

    case Images.update_description(description, description_params) do
      {:ok, description} ->
        conn
        |> put_flash(:info, "Description updated successfully.")
        |> redirect(to: Routes.images_description_path(conn, :show, description))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", description: description, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    description = Images.get_description!(id)
    {:ok, _description} = Images.delete_description(description)

    conn
    |> put_flash(:info, "Description deleted successfully.")
    |> redirect(to: Routes.images_description_path(conn, :index))
  end
end
