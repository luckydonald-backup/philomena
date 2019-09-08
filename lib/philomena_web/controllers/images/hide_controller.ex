defmodule PhilomenaWeb.Images.HideController do
  use PhilomenaWeb, :controller

  alias Philomena.Images
  alias Philomena.Images.Hide

  def index(conn, _params) do
    image_hides = Images.list_image_hides()
    render(conn, "index.html", image_hides: image_hides)
  end

  def new(conn, _params) do
    changeset = Images.change_hide(%Hide{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"hide" => hide_params}) do
    case Images.create_hide(hide_params) do
      {:ok, hide} ->
        conn
        |> put_flash(:info, "Hide created successfully.")
        |> redirect(to: Routes.images_hide_path(conn, :show, hide))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    hide = Images.get_hide!(id)
    render(conn, "show.html", hide: hide)
  end

  def edit(conn, %{"id" => id}) do
    hide = Images.get_hide!(id)
    changeset = Images.change_hide(hide)
    render(conn, "edit.html", hide: hide, changeset: changeset)
  end

  def update(conn, %{"id" => id, "hide" => hide_params}) do
    hide = Images.get_hide!(id)

    case Images.update_hide(hide, hide_params) do
      {:ok, hide} ->
        conn
        |> put_flash(:info, "Hide updated successfully.")
        |> redirect(to: Routes.images_hide_path(conn, :show, hide))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", hide: hide, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    hide = Images.get_hide!(id)
    {:ok, _hide} = Images.delete_hide(hide)

    conn
    |> put_flash(:info, "Hide deleted successfully.")
    |> redirect(to: Routes.images_hide_path(conn, :index))
  end
end
