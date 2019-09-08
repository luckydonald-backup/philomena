defmodule PhilomenaWeb.FingerprintProfiles.TagChangeController do
  use PhilomenaWeb, :controller

  alias Philomena.FingerprintProfiles
  alias Philomena.FingerprintProfiles.TagChange

  def index(conn, _params) do
    tag_changes = FingerprintProfiles.list_tag_changes()
    render(conn, "index.html", tag_changes: tag_changes)
  end

  def new(conn, _params) do
    changeset = FingerprintProfiles.change_tag_change(%TagChange{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tag_change" => tag_change_params}) do
    case FingerprintProfiles.create_tag_change(tag_change_params) do
      {:ok, tag_change} ->
        conn
        |> put_flash(:info, "Tag change created successfully.")
        |> redirect(to: Routes.fingerprint_profiles_tag_change_path(conn, :show, tag_change))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tag_change = FingerprintProfiles.get_tag_change!(id)
    render(conn, "show.html", tag_change: tag_change)
  end

  def edit(conn, %{"id" => id}) do
    tag_change = FingerprintProfiles.get_tag_change!(id)
    changeset = FingerprintProfiles.change_tag_change(tag_change)
    render(conn, "edit.html", tag_change: tag_change, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tag_change" => tag_change_params}) do
    tag_change = FingerprintProfiles.get_tag_change!(id)

    case FingerprintProfiles.update_tag_change(tag_change, tag_change_params) do
      {:ok, tag_change} ->
        conn
        |> put_flash(:info, "Tag change updated successfully.")
        |> redirect(to: Routes.fingerprint_profiles_tag_change_path(conn, :show, tag_change))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tag_change: tag_change, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag_change = FingerprintProfiles.get_tag_change!(id)
    {:ok, _tag_change} = FingerprintProfiles.delete_tag_change(tag_change)

    conn
    |> put_flash(:info, "Tag change deleted successfully.")
    |> redirect(to: Routes.fingerprint_profiles_tag_change_path(conn, :index))
  end
end
