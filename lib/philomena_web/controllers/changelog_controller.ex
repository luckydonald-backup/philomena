defmodule PhilomenaWeb.ChangelogController do
  use PhilomenaWeb, :controller

  alias Philomena.Changelogs
  alias Philomena.Changelogs.Changelog

  def index(conn, _params) do
    changelogs = Changelogs.list_changelogs()
    render(conn, "index.html", changelogs: changelogs)
  end

  def new(conn, _params) do
    changeset = Changelogs.change_changelog(%Changelog{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"changelog" => changelog_params}) do
    case Changelogs.create_changelog(changelog_params) do
      {:ok, changelog} ->
        conn
        |> put_flash(:info, "Changelog created successfully.")
        |> redirect(to: Routes.changelog_path(conn, :show, changelog))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    changelog = Changelogs.get_changelog!(id)
    render(conn, "show.html", changelog: changelog)
  end

  def edit(conn, %{"id" => id}) do
    changelog = Changelogs.get_changelog!(id)
    changeset = Changelogs.change_changelog(changelog)
    render(conn, "edit.html", changelog: changelog, changeset: changeset)
  end

  def update(conn, %{"id" => id, "changelog" => changelog_params}) do
    changelog = Changelogs.get_changelog!(id)

    case Changelogs.update_changelog(changelog, changelog_params) do
      {:ok, changelog} ->
        conn
        |> put_flash(:info, "Changelog updated successfully.")
        |> redirect(to: Routes.changelog_path(conn, :show, changelog))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changelog: changelog, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    changelog = Changelogs.get_changelog!(id)
    {:ok, _changelog} = Changelogs.delete_changelog(changelog)

    conn
    |> put_flash(:info, "Changelog deleted successfully.")
    |> redirect(to: Routes.changelog_path(conn, :index))
  end
end
