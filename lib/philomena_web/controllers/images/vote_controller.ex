defmodule PhilomenaWeb.Images.VoteController do
  use PhilomenaWeb, :controller

  alias Philomena.Images
  alias Philomena.Images.Vote

  def index(conn, _params) do
    image_votes = Images.list_image_votes()
    render(conn, "index.html", image_votes: image_votes)
  end

  def new(conn, _params) do
    changeset = Images.change_vote(%Vote{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"vote" => vote_params}) do
    case Images.create_vote(vote_params) do
      {:ok, vote} ->
        conn
        |> put_flash(:info, "Vote created successfully.")
        |> redirect(to: Routes.images_vote_path(conn, :show, vote))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    vote = Images.get_vote!(id)
    render(conn, "show.html", vote: vote)
  end

  def edit(conn, %{"id" => id}) do
    vote = Images.get_vote!(id)
    changeset = Images.change_vote(vote)
    render(conn, "edit.html", vote: vote, changeset: changeset)
  end

  def update(conn, %{"id" => id, "vote" => vote_params}) do
    vote = Images.get_vote!(id)

    case Images.update_vote(vote, vote_params) do
      {:ok, vote} ->
        conn
        |> put_flash(:info, "Vote updated successfully.")
        |> redirect(to: Routes.images_vote_path(conn, :show, vote))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", vote: vote, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    vote = Images.get_vote!(id)
    {:ok, _vote} = Images.delete_vote(vote)

    conn
    |> put_flash(:info, "Vote deleted successfully.")
    |> redirect(to: Routes.images_vote_path(conn, :index))
  end
end
