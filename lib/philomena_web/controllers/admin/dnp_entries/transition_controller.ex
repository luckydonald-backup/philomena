defmodule PhilomenaWeb.Admin.DnpEntries.TransitionController do
  use PhilomenaWeb, :controller

  alias Philomena.DnpEntries
  alias Philomena.DnpEntries.Transition

  def index(conn, _params) do
    transitions = DnpEntries.list_transitions()
    render(conn, "index.html", transitions: transitions)
  end

  def new(conn, _params) do
    changeset = DnpEntries.change_transition(%Transition{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"transition" => transition_params}) do
    case DnpEntries.create_transition(transition_params) do
      {:ok, transition} ->
        conn
        |> put_flash(:info, "Transition created successfully.")
        |> redirect(to: Routes.admin_dnp_entries_transition_path(conn, :show, transition))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    transition = DnpEntries.get_transition!(id)
    render(conn, "show.html", transition: transition)
  end

  def edit(conn, %{"id" => id}) do
    transition = DnpEntries.get_transition!(id)
    changeset = DnpEntries.change_transition(transition)
    render(conn, "edit.html", transition: transition, changeset: changeset)
  end

  def update(conn, %{"id" => id, "transition" => transition_params}) do
    transition = DnpEntries.get_transition!(id)

    case DnpEntries.update_transition(transition, transition_params) do
      {:ok, transition} ->
        conn
        |> put_flash(:info, "Transition updated successfully.")
        |> redirect(to: Routes.admin_dnp_entries_transition_path(conn, :show, transition))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", transition: transition, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    transition = DnpEntries.get_transition!(id)
    {:ok, _transition} = DnpEntries.delete_transition(transition)

    conn
    |> put_flash(:info, "Transition deleted successfully.")
    |> redirect(to: Routes.admin_dnp_entries_transition_path(conn, :index))
  end
end
