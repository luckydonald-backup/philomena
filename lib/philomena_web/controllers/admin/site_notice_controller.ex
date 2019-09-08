defmodule PhilomenaWeb.Admin.SiteNoticeController do
  use PhilomenaWeb, :controller

  alias Philomena.SiteNotices
  alias Philomena.SiteNotices.SiteNotice

  def index(conn, _params) do
    site_notices = SiteNotices.list_site_notices()
    render(conn, "index.html", site_notices: site_notices)
  end

  def new(conn, _params) do
    changeset = SiteNotices.change_site_notice(%SiteNotice{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"site_notice" => site_notice_params}) do
    case SiteNotices.create_site_notice(site_notice_params) do
      {:ok, site_notice} ->
        conn
        |> put_flash(:info, "Site notice created successfully.")
        |> redirect(to: Routes.admin_site_notice_path(conn, :show, site_notice))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    site_notice = SiteNotices.get_site_notice!(id)
    render(conn, "show.html", site_notice: site_notice)
  end

  def edit(conn, %{"id" => id}) do
    site_notice = SiteNotices.get_site_notice!(id)
    changeset = SiteNotices.change_site_notice(site_notice)
    render(conn, "edit.html", site_notice: site_notice, changeset: changeset)
  end

  def update(conn, %{"id" => id, "site_notice" => site_notice_params}) do
    site_notice = SiteNotices.get_site_notice!(id)

    case SiteNotices.update_site_notice(site_notice, site_notice_params) do
      {:ok, site_notice} ->
        conn
        |> put_flash(:info, "Site notice updated successfully.")
        |> redirect(to: Routes.admin_site_notice_path(conn, :show, site_notice))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", site_notice: site_notice, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    site_notice = SiteNotices.get_site_notice!(id)
    {:ok, _site_notice} = SiteNotices.delete_site_notice(site_notice)

    conn
    |> put_flash(:info, "Site notice deleted successfully.")
    |> redirect(to: Routes.admin_site_notice_path(conn, :index))
  end
end
