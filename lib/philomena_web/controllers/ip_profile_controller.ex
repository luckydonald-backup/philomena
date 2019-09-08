defmodule PhilomenaWeb.IpProfileController do
  use PhilomenaWeb, :controller

  alias Philomena.IpProfiles
  alias Philomena.IpProfiles.IpProfile

  def index(conn, _params) do
    ip_profiles = IpProfiles.list_ip_profiles()
    render(conn, "index.html", ip_profiles: ip_profiles)
  end

  def new(conn, _params) do
    changeset = IpProfiles.change_ip_profile(%IpProfile{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ip_profile" => ip_profile_params}) do
    case IpProfiles.create_ip_profile(ip_profile_params) do
      {:ok, ip_profile} ->
        conn
        |> put_flash(:info, "Ip profile created successfully.")
        |> redirect(to: Routes.ip_profile_path(conn, :show, ip_profile))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    ip_profile = IpProfiles.get_ip_profile!(id)
    render(conn, "show.html", ip_profile: ip_profile)
  end

  def edit(conn, %{"id" => id}) do
    ip_profile = IpProfiles.get_ip_profile!(id)
    changeset = IpProfiles.change_ip_profile(ip_profile)
    render(conn, "edit.html", ip_profile: ip_profile, changeset: changeset)
  end

  def update(conn, %{"id" => id, "ip_profile" => ip_profile_params}) do
    ip_profile = IpProfiles.get_ip_profile!(id)

    case IpProfiles.update_ip_profile(ip_profile, ip_profile_params) do
      {:ok, ip_profile} ->
        conn
        |> put_flash(:info, "Ip profile updated successfully.")
        |> redirect(to: Routes.ip_profile_path(conn, :show, ip_profile))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", ip_profile: ip_profile, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ip_profile = IpProfiles.get_ip_profile!(id)
    {:ok, _ip_profile} = IpProfiles.delete_ip_profile(ip_profile)

    conn
    |> put_flash(:info, "Ip profile deleted successfully.")
    |> redirect(to: Routes.ip_profile_path(conn, :index))
  end
end
