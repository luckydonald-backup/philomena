defmodule PhilomenaWeb.Profiles.IpHistoryController do
  use PhilomenaWeb, :controller

  alias Philomena.Profiles
  alias Philomena.Profiles.IpHistory

  def index(conn, _params) do
    ip_histories = Profiles.list_ip_histories()
    render(conn, "index.html", ip_histories: ip_histories)
  end

  def new(conn, _params) do
    changeset = Profiles.change_ip_history(%IpHistory{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ip_history" => ip_history_params}) do
    case Profiles.create_ip_history(ip_history_params) do
      {:ok, ip_history} ->
        conn
        |> put_flash(:info, "Ip history created successfully.")
        |> redirect(to: Routes.profiles_ip_history_path(conn, :show, ip_history))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    ip_history = Profiles.get_ip_history!(id)
    render(conn, "show.html", ip_history: ip_history)
  end

  def edit(conn, %{"id" => id}) do
    ip_history = Profiles.get_ip_history!(id)
    changeset = Profiles.change_ip_history(ip_history)
    render(conn, "edit.html", ip_history: ip_history, changeset: changeset)
  end

  def update(conn, %{"id" => id, "ip_history" => ip_history_params}) do
    ip_history = Profiles.get_ip_history!(id)

    case Profiles.update_ip_history(ip_history, ip_history_params) do
      {:ok, ip_history} ->
        conn
        |> put_flash(:info, "Ip history updated successfully.")
        |> redirect(to: Routes.profiles_ip_history_path(conn, :show, ip_history))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", ip_history: ip_history, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ip_history = Profiles.get_ip_history!(id)
    {:ok, _ip_history} = Profiles.delete_ip_history(ip_history)

    conn
    |> put_flash(:info, "Ip history deleted successfully.")
    |> redirect(to: Routes.profiles_ip_history_path(conn, :index))
  end
end
