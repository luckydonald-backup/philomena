defmodule PhilomenaWeb.TagChanges.MassRevertController do
  use PhilomenaWeb, :controller

  alias Philomena.TagChanges
  alias Philomena.TagChanges.MassRevert

  def index(conn, _params) do
    mass_revert = TagChanges.list_mass_revert()
    render(conn, "index.html", mass_revert: mass_revert)
  end

  def new(conn, _params) do
    changeset = TagChanges.change_mass_revert(%MassRevert{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"mass_revert" => mass_revert_params}) do
    case TagChanges.create_mass_revert(mass_revert_params) do
      {:ok, mass_revert} ->
        conn
        |> put_flash(:info, "Mass revert created successfully.")
        |> redirect(to: Routes.tag_changes_mass_revert_path(conn, :show, mass_revert))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    mass_revert = TagChanges.get_mass_revert!(id)
    render(conn, "show.html", mass_revert: mass_revert)
  end

  def edit(conn, %{"id" => id}) do
    mass_revert = TagChanges.get_mass_revert!(id)
    changeset = TagChanges.change_mass_revert(mass_revert)
    render(conn, "edit.html", mass_revert: mass_revert, changeset: changeset)
  end

  def update(conn, %{"id" => id, "mass_revert" => mass_revert_params}) do
    mass_revert = TagChanges.get_mass_revert!(id)

    case TagChanges.update_mass_revert(mass_revert, mass_revert_params) do
      {:ok, mass_revert} ->
        conn
        |> put_flash(:info, "Mass revert updated successfully.")
        |> redirect(to: Routes.tag_changes_mass_revert_path(conn, :show, mass_revert))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", mass_revert: mass_revert, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    mass_revert = TagChanges.get_mass_revert!(id)
    {:ok, _mass_revert} = TagChanges.delete_mass_revert(mass_revert)

    conn
    |> put_flash(:info, "Mass revert deleted successfully.")
    |> redirect(to: Routes.tag_changes_mass_revert_path(conn, :index))
  end
end
