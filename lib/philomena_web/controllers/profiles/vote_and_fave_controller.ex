defmodule PhilomenaWeb.Profiles.VoteAndFaveController do
  use PhilomenaWeb, :controller

  alias Philomena.Profiles
  alias Philomena.Profiles.VoteAndFave

  def index(conn, _params) do
    votes_and_faves = Profiles.list_votes_and_faves()
    render(conn, "index.html", votes_and_faves: votes_and_faves)
  end

  def new(conn, _params) do
    changeset = Profiles.change_vote_and_fave(%VoteAndFave{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"vote_and_fave" => vote_and_fave_params}) do
    case Profiles.create_vote_and_fave(vote_and_fave_params) do
      {:ok, vote_and_fave} ->
        conn
        |> put_flash(:info, "Vote and fave created successfully.")
        |> redirect(to: Routes.profiles_vote_and_fave_path(conn, :show, vote_and_fave))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    vote_and_fave = Profiles.get_vote_and_fave!(id)
    render(conn, "show.html", vote_and_fave: vote_and_fave)
  end

  def edit(conn, %{"id" => id}) do
    vote_and_fave = Profiles.get_vote_and_fave!(id)
    changeset = Profiles.change_vote_and_fave(vote_and_fave)
    render(conn, "edit.html", vote_and_fave: vote_and_fave, changeset: changeset)
  end

  def update(conn, %{"id" => id, "vote_and_fave" => vote_and_fave_params}) do
    vote_and_fave = Profiles.get_vote_and_fave!(id)

    case Profiles.update_vote_and_fave(vote_and_fave, vote_and_fave_params) do
      {:ok, vote_and_fave} ->
        conn
        |> put_flash(:info, "Vote and fave updated successfully.")
        |> redirect(to: Routes.profiles_vote_and_fave_path(conn, :show, vote_and_fave))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", vote_and_fave: vote_and_fave, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    vote_and_fave = Profiles.get_vote_and_fave!(id)
    {:ok, _vote_and_fave} = Profiles.delete_vote_and_fave(vote_and_fave)

    conn
    |> put_flash(:info, "Vote and fave deleted successfully.")
    |> redirect(to: Routes.profiles_vote_and_fave_path(conn, :index))
  end
end
