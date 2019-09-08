defmodule PhilomenaWeb.Admin.FingerprintController do
  use PhilomenaWeb, :controller

  alias Philomena.Bans
  alias Philomena.Bans.Fingerprint

  def index(conn, _params) do
    fingerprint_bans = Bans.list_fingerprint_bans()
    render(conn, "index.html", fingerprint_bans: fingerprint_bans)
  end

  def new(conn, _params) do
    changeset = Bans.change_fingerprint(%Fingerprint{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"fingerprint" => fingerprint_params}) do
    case Bans.create_fingerprint(fingerprint_params) do
      {:ok, fingerprint} ->
        conn
        |> put_flash(:info, "Fingerprint created successfully.")
        |> redirect(to: Routes.admin_fingerprint_path(conn, :show, fingerprint))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    fingerprint = Bans.get_fingerprint!(id)
    render(conn, "show.html", fingerprint: fingerprint)
  end

  def edit(conn, %{"id" => id}) do
    fingerprint = Bans.get_fingerprint!(id)
    changeset = Bans.change_fingerprint(fingerprint)
    render(conn, "edit.html", fingerprint: fingerprint, changeset: changeset)
  end

  def update(conn, %{"id" => id, "fingerprint" => fingerprint_params}) do
    fingerprint = Bans.get_fingerprint!(id)

    case Bans.update_fingerprint(fingerprint, fingerprint_params) do
      {:ok, fingerprint} ->
        conn
        |> put_flash(:info, "Fingerprint updated successfully.")
        |> redirect(to: Routes.admin_fingerprint_path(conn, :show, fingerprint))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", fingerprint: fingerprint, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    fingerprint = Bans.get_fingerprint!(id)
    {:ok, _fingerprint} = Bans.delete_fingerprint(fingerprint)

    conn
    |> put_flash(:info, "Fingerprint deleted successfully.")
    |> redirect(to: Routes.admin_fingerprint_path(conn, :index))
  end
end
