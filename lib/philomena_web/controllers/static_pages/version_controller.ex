defmodule PhilomenaWeb.StaticPages.VersionController do
  use PhilomenaWeb, :controller

  alias Philomena.StaticPage
  alias Philomena.StaticPage.Version

  def index(conn, _params) do
    static_page_versions = StaticPage.list_static_page_versions()
    render(conn, "index.html", static_page_versions: static_page_versions)
  end

  def new(conn, _params) do
    changeset = StaticPage.change_version(%Version{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"version" => version_params}) do
    case StaticPage.create_version(version_params) do
      {:ok, version} ->
        conn
        |> put_flash(:info, "Version created successfully.")
        |> redirect(to: Routes.static_pages_version_path(conn, :show, version))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    version = StaticPage.get_version!(id)
    render(conn, "show.html", version: version)
  end

  def edit(conn, %{"id" => id}) do
    version = StaticPage.get_version!(id)
    changeset = StaticPage.change_version(version)
    render(conn, "edit.html", version: version, changeset: changeset)
  end

  def update(conn, %{"id" => id, "version" => version_params}) do
    version = StaticPage.get_version!(id)

    case StaticPage.update_version(version, version_params) do
      {:ok, version} ->
        conn
        |> put_flash(:info, "Version updated successfully.")
        |> redirect(to: Routes.static_pages_version_path(conn, :show, version))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", version: version, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    version = StaticPage.get_version!(id)
    {:ok, _version} = StaticPage.delete_version(version)

    conn
    |> put_flash(:info, "Version deleted successfully.")
    |> redirect(to: Routes.static_pages_version_path(conn, :index))
  end
end
