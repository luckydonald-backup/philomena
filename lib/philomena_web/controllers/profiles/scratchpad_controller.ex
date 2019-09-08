defmodule PhilomenaWeb.Profiles.ScratchpadController do
  use PhilomenaWeb, :controller

  alias Philomena.Profiles
  alias Philomena.Profiles.Scratchpad

  def index(conn, _params) do
    scratchpads = Profiles.list_scratchpads()
    render(conn, "index.html", scratchpads: scratchpads)
  end

  def new(conn, _params) do
    changeset = Profiles.change_scratchpad(%Scratchpad{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"scratchpad" => scratchpad_params}) do
    case Profiles.create_scratchpad(scratchpad_params) do
      {:ok, scratchpad} ->
        conn
        |> put_flash(:info, "Scratchpad created successfully.")
        |> redirect(to: Routes.profiles_scratchpad_path(conn, :show, scratchpad))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    scratchpad = Profiles.get_scratchpad!(id)
    render(conn, "show.html", scratchpad: scratchpad)
  end

  def edit(conn, %{"id" => id}) do
    scratchpad = Profiles.get_scratchpad!(id)
    changeset = Profiles.change_scratchpad(scratchpad)
    render(conn, "edit.html", scratchpad: scratchpad, changeset: changeset)
  end

  def update(conn, %{"id" => id, "scratchpad" => scratchpad_params}) do
    scratchpad = Profiles.get_scratchpad!(id)

    case Profiles.update_scratchpad(scratchpad, scratchpad_params) do
      {:ok, scratchpad} ->
        conn
        |> put_flash(:info, "Scratchpad updated successfully.")
        |> redirect(to: Routes.profiles_scratchpad_path(conn, :show, scratchpad))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", scratchpad: scratchpad, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    scratchpad = Profiles.get_scratchpad!(id)
    {:ok, _scratchpad} = Profiles.delete_scratchpad(scratchpad)

    conn
    |> put_flash(:info, "Scratchpad deleted successfully.")
    |> redirect(to: Routes.profiles_scratchpad_path(conn, :index))
  end
end
