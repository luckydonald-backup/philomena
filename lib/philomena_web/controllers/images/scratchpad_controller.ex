defmodule PhilomenaWeb.Images.ScratchpadController do
  use PhilomenaWeb, :controller

  alias Philomena.Images
  alias Philomena.Images.Scratchpad

  def index(conn, _params) do
    scratchpad = Images.list_scratchpad()
    render(conn, "index.html", scratchpad: scratchpad)
  end

  def new(conn, _params) do
    changeset = Images.change_scratchpad(%Scratchpad{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"scratchpad" => scratchpad_params}) do
    case Images.create_scratchpad(scratchpad_params) do
      {:ok, scratchpad} ->
        conn
        |> put_flash(:info, "Scratchpad created successfully.")
        |> redirect(to: Routes.images_scratchpad_path(conn, :show, scratchpad))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    scratchpad = Images.get_scratchpad!(id)
    render(conn, "show.html", scratchpad: scratchpad)
  end

  def edit(conn, %{"id" => id}) do
    scratchpad = Images.get_scratchpad!(id)
    changeset = Images.change_scratchpad(scratchpad)
    render(conn, "edit.html", scratchpad: scratchpad, changeset: changeset)
  end

  def update(conn, %{"id" => id, "scratchpad" => scratchpad_params}) do
    scratchpad = Images.get_scratchpad!(id)

    case Images.update_scratchpad(scratchpad, scratchpad_params) do
      {:ok, scratchpad} ->
        conn
        |> put_flash(:info, "Scratchpad updated successfully.")
        |> redirect(to: Routes.images_scratchpad_path(conn, :show, scratchpad))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", scratchpad: scratchpad, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    scratchpad = Images.get_scratchpad!(id)
    {:ok, _scratchpad} = Images.delete_scratchpad(scratchpad)

    conn
    |> put_flash(:info, "Scratchpad deleted successfully.")
    |> redirect(to: Routes.images_scratchpad_path(conn, :index))
  end
end
