defmodule PhilomenaWeb.Admin.UserLinks.TransitionController do
  use PhilomenaWeb, :controller

  alias Philomena.UserLink
  alias Philomena.UserLink.Transition

  def index(conn, _params) do
    user_links = UserLink.list_user_links()
    render(conn, "index.html", user_links: user_links)
  end

  def new(conn, _params) do
    changeset = UserLink.change_transition(%Transition{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"transition" => transition_params}) do
    case UserLink.create_transition(transition_params) do
      {:ok, transition} ->
        conn
        |> put_flash(:info, "Transition created successfully.")
        |> redirect(to: Routes.admin_user_links_transition_path(conn, :show, transition))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    transition = UserLink.get_transition!(id)
    render(conn, "show.html", transition: transition)
  end

  def edit(conn, %{"id" => id}) do
    transition = UserLink.get_transition!(id)
    changeset = UserLink.change_transition(transition)
    render(conn, "edit.html", transition: transition, changeset: changeset)
  end

  def update(conn, %{"id" => id, "transition" => transition_params}) do
    transition = UserLink.get_transition!(id)

    case UserLink.update_transition(transition, transition_params) do
      {:ok, transition} ->
        conn
        |> put_flash(:info, "Transition updated successfully.")
        |> redirect(to: Routes.admin_user_links_transition_path(conn, :show, transition))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", transition: transition, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    transition = UserLink.get_transition!(id)
    {:ok, _transition} = UserLink.delete_transition(transition)

    conn
    |> put_flash(:info, "Transition deleted successfully.")
    |> redirect(to: Routes.admin_user_links_transition_path(conn, :index))
  end
end
