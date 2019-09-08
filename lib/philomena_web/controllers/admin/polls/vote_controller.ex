defmodule PhilomenaWeb.Admin.Polls.VoteController do
  use PhilomenaWeb, :controller

  alias Philomena.Polls
  alias Philomena.Polls.Vote

  def index(conn, _params) do
    poll_votes = Polls.list_poll_votes()
    render(conn, "index.html", poll_votes: poll_votes)
  end

  def new(conn, _params) do
    changeset = Polls.change_vote(%Vote{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"vote" => vote_params}) do
    case Polls.create_vote(vote_params) do
      {:ok, vote} ->
        conn
        |> put_flash(:info, "Vote created successfully.")
        |> redirect(to: Routes.admin_polls_vote_path(conn, :show, vote))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    vote = Polls.get_vote!(id)
    render(conn, "show.html", vote: vote)
  end

  def edit(conn, %{"id" => id}) do
    vote = Polls.get_vote!(id)
    changeset = Polls.change_vote(vote)
    render(conn, "edit.html", vote: vote, changeset: changeset)
  end

  def update(conn, %{"id" => id, "vote" => vote_params}) do
    vote = Polls.get_vote!(id)

    case Polls.update_vote(vote, vote_params) do
      {:ok, vote} ->
        conn
        |> put_flash(:info, "Vote updated successfully.")
        |> redirect(to: Routes.admin_polls_vote_path(conn, :show, vote))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", vote: vote, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    vote = Polls.get_vote!(id)
    {:ok, _vote} = Polls.delete_vote(vote)

    conn
    |> put_flash(:info, "Vote deleted successfully.")
    |> redirect(to: Routes.admin_polls_vote_path(conn, :index))
  end
end
