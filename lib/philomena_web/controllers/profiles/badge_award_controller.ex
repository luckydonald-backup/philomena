defmodule PhilomenaWeb.Profiles.BadgeAwardController do
  use PhilomenaWeb, :controller

  alias Philomena.Profiles
  alias Philomena.Profiles.BadgeAward

  def index(conn, _params) do
    badge_awards = Profiles.list_badge_awards()
    render(conn, "index.html", badge_awards: badge_awards)
  end

  def new(conn, _params) do
    changeset = Profiles.change_badge_award(%BadgeAward{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"badge_award" => badge_award_params}) do
    case Profiles.create_badge_award(badge_award_params) do
      {:ok, badge_award} ->
        conn
        |> put_flash(:info, "Badge award created successfully.")
        |> redirect(to: Routes.profiles_badge_award_path(conn, :show, badge_award))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    badge_award = Profiles.get_badge_award!(id)
    render(conn, "show.html", badge_award: badge_award)
  end

  def edit(conn, %{"id" => id}) do
    badge_award = Profiles.get_badge_award!(id)
    changeset = Profiles.change_badge_award(badge_award)
    render(conn, "edit.html", badge_award: badge_award, changeset: changeset)
  end

  def update(conn, %{"id" => id, "badge_award" => badge_award_params}) do
    badge_award = Profiles.get_badge_award!(id)

    case Profiles.update_badge_award(badge_award, badge_award_params) do
      {:ok, badge_award} ->
        conn
        |> put_flash(:info, "Badge award updated successfully.")
        |> redirect(to: Routes.profiles_badge_award_path(conn, :show, badge_award))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", badge_award: badge_award, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    badge_award = Profiles.get_badge_award!(id)
    {:ok, _badge_award} = Profiles.delete_badge_award(badge_award)

    conn
    |> put_flash(:info, "Badge award deleted successfully.")
    |> redirect(to: Routes.profiles_badge_award_path(conn, :index))
  end
end
