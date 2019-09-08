defmodule PhilomenaWeb.Images.HashController do
  use PhilomenaWeb, :controller

  alias Philomena.Images
  alias Philomena.Images.Hash

  def index(conn, _params) do
    image_hashes = Images.list_image_hashes()
    render(conn, "index.html", image_hashes: image_hashes)
  end

  def new(conn, _params) do
    changeset = Images.change_hash(%Hash{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"hash" => hash_params}) do
    case Images.create_hash(hash_params) do
      {:ok, hash} ->
        conn
        |> put_flash(:info, "Hash created successfully.")
        |> redirect(to: Routes.images_hash_path(conn, :show, hash))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    hash = Images.get_hash!(id)
    render(conn, "show.html", hash: hash)
  end

  def edit(conn, %{"id" => id}) do
    hash = Images.get_hash!(id)
    changeset = Images.change_hash(hash)
    render(conn, "edit.html", hash: hash, changeset: changeset)
  end

  def update(conn, %{"id" => id, "hash" => hash_params}) do
    hash = Images.get_hash!(id)

    case Images.update_hash(hash, hash_params) do
      {:ok, hash} ->
        conn
        |> put_flash(:info, "Hash updated successfully.")
        |> redirect(to: Routes.images_hash_path(conn, :show, hash))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", hash: hash, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    hash = Images.get_hash!(id)
    {:ok, _hash} = Images.delete_hash(hash)

    conn
    |> put_flash(:info, "Hash deleted successfully.")
    |> redirect(to: Routes.images_hash_path(conn, :index))
  end
end
