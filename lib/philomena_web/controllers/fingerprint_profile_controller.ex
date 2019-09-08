defmodule PhilomenaWeb.FingerprintProfileController do
  use PhilomenaWeb, :controller

  alias Philomena.FingerprintProfiles
  alias Philomena.FingerprintProfiles.FingerprintProfile

  def index(conn, _params) do
    fingerprint_profiles = FingerprintProfiles.list_fingerprint_profiles()
    render(conn, "index.html", fingerprint_profiles: fingerprint_profiles)
  end

  def new(conn, _params) do
    changeset = FingerprintProfiles.change_fingerprint_profile(%FingerprintProfile{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"fingerprint_profile" => fingerprint_profile_params}) do
    case FingerprintProfiles.create_fingerprint_profile(fingerprint_profile_params) do
      {:ok, fingerprint_profile} ->
        conn
        |> put_flash(:info, "Fingerprint profile created successfully.")
        |> redirect(to: Routes.fingerprint_profile_path(conn, :show, fingerprint_profile))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    fingerprint_profile = FingerprintProfiles.get_fingerprint_profile!(id)
    render(conn, "show.html", fingerprint_profile: fingerprint_profile)
  end

  def edit(conn, %{"id" => id}) do
    fingerprint_profile = FingerprintProfiles.get_fingerprint_profile!(id)
    changeset = FingerprintProfiles.change_fingerprint_profile(fingerprint_profile)
    render(conn, "edit.html", fingerprint_profile: fingerprint_profile, changeset: changeset)
  end

  def update(conn, %{"id" => id, "fingerprint_profile" => fingerprint_profile_params}) do
    fingerprint_profile = FingerprintProfiles.get_fingerprint_profile!(id)

    case FingerprintProfiles.update_fingerprint_profile(fingerprint_profile, fingerprint_profile_params) do
      {:ok, fingerprint_profile} ->
        conn
        |> put_flash(:info, "Fingerprint profile updated successfully.")
        |> redirect(to: Routes.fingerprint_profile_path(conn, :show, fingerprint_profile))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", fingerprint_profile: fingerprint_profile, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    fingerprint_profile = FingerprintProfiles.get_fingerprint_profile!(id)
    {:ok, _fingerprint_profile} = FingerprintProfiles.delete_fingerprint_profile(fingerprint_profile)

    conn
    |> put_flash(:info, "Fingerprint profile deleted successfully.")
    |> redirect(to: Routes.fingerprint_profile_path(conn, :index))
  end
end
