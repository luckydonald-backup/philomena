defmodule PhilomenaWeb.Topics.Polls.VoteController do
  use PhilomenaWeb, :controller

  alias Philomena.Topics
  alias Philomena.Topics.Vote

  def index(conn, _params) do
    voters = Topics.list_voters()
    render(conn, "index.html", voters: voters)
  end

  def new(conn, _params) do
    changeset = Topics.change_vote(%Vote{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"vote" => vote_params}) do
    case Topics.create_vote(vote_params) do
      {:ok, vote} ->
        conn
        |> put_flash(:info, "Vote created successfully.")
        |> redirect(to: Routes.topics_polls_vote_path(conn, :show, vote))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    vote = Topics.get_vote!(id)
    render(conn, "show.html", vote: vote)
  end

  def edit(conn, %{"id" => id}) do
    vote = Topics.get_vote!(id)
    changeset = Topics.change_vote(vote)
    render(conn, "edit.html", vote: vote, changeset: changeset)
  end

  def update(conn, %{"id" => id, "vote" => vote_params}) do
    vote = Topics.get_vote!(id)

    case Topics.update_vote(vote, vote_params) do
      {:ok, vote} ->
        conn
        |> put_flash(:info, "Vote updated successfully.")
        |> redirect(to: Routes.topics_polls_vote_path(conn, :show, vote))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", vote: vote, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    vote = Topics.get_vote!(id)
    {:ok, _vote} = Topics.delete_vote(vote)

    conn
    |> put_flash(:info, "Vote deleted successfully.")
    |> redirect(to: Routes.topics_polls_vote_path(conn, :index))
  end
end
