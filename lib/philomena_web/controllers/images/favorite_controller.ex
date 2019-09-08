defmodule PhilomenaWeb.Images.FavoriteController do
  use PhilomenaWeb, :controller

  alias Philomena.Images
  alias Philomena.Images.Favorite

  def index(conn, _params) do
    image_faves = Images.list_image_faves()
    render(conn, "index.html", image_faves: image_faves)
  end

  def new(conn, _params) do
    changeset = Images.change_favorite(%Favorite{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"favorite" => favorite_params}) do
    case Images.create_favorite(favorite_params) do
      {:ok, favorite} ->
        conn
        |> put_flash(:info, "Favorite created successfully.")
        |> redirect(to: Routes.images_favorite_path(conn, :show, favorite))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    favorite = Images.get_favorite!(id)
    render(conn, "show.html", favorite: favorite)
  end

  def edit(conn, %{"id" => id}) do
    favorite = Images.get_favorite!(id)
    changeset = Images.change_favorite(favorite)
    render(conn, "edit.html", favorite: favorite, changeset: changeset)
  end

  def update(conn, %{"id" => id, "favorite" => favorite_params}) do
    favorite = Images.get_favorite!(id)

    case Images.update_favorite(favorite, favorite_params) do
      {:ok, favorite} ->
        conn
        |> put_flash(:info, "Favorite updated successfully.")
        |> redirect(to: Routes.images_favorite_path(conn, :show, favorite))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", favorite: favorite, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    favorite = Images.get_favorite!(id)
    {:ok, _favorite} = Images.delete_favorite(favorite)

    conn
    |> put_flash(:info, "Favorite deleted successfully.")
    |> redirect(to: Routes.images_favorite_path(conn, :index))
  end
end
