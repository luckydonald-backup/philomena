defmodule PhilomenaWeb.PollVoteController do
  use PhilomenaWeb, :controller

  alias Philomena.PollVotes
  alias Philomena.PollVotes.PollVote

  def index(conn, _params) do
    poll_votes = PollVotes.list_poll_votes()
    render(conn, "index.html", poll_votes: poll_votes)
  end

  def new(conn, _params) do
    changeset = PollVotes.change_poll_vote(%PollVote{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"poll_vote" => poll_vote_params}) do
    case PollVotes.create_poll_vote(poll_vote_params) do
      {:ok, poll_vote} ->
        conn
        |> put_flash(:info, "Poll vote created successfully.")
        |> redirect(to: Routes.poll_vote_path(conn, :show, poll_vote))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    poll_vote = PollVotes.get_poll_vote!(id)
    render(conn, "show.html", poll_vote: poll_vote)
  end

  def edit(conn, %{"id" => id}) do
    poll_vote = PollVotes.get_poll_vote!(id)
    changeset = PollVotes.change_poll_vote(poll_vote)
    render(conn, "edit.html", poll_vote: poll_vote, changeset: changeset)
  end

  def update(conn, %{"id" => id, "poll_vote" => poll_vote_params}) do
    poll_vote = PollVotes.get_poll_vote!(id)

    case PollVotes.update_poll_vote(poll_vote, poll_vote_params) do
      {:ok, poll_vote} ->
        conn
        |> put_flash(:info, "Poll vote updated successfully.")
        |> redirect(to: Routes.poll_vote_path(conn, :show, poll_vote))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", poll_vote: poll_vote, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    poll_vote = PollVotes.get_poll_vote!(id)
    {:ok, _poll_vote} = PollVotes.delete_poll_vote(poll_vote)

    conn
    |> put_flash(:info, "Poll vote deleted successfully.")
    |> redirect(to: Routes.poll_vote_path(conn, :index))
  end
end
