defmodule PhilomenaWeb.Profiles.DownvoteController do
  use PhilomenaWeb, :controller

  alias Philomena.Profiles
  alias Philomena.Profiles.Downvote

  def index(conn, _params) do
    downvotes = Profiles.list_downvotes()
    render(conn, "index.html", downvotes: downvotes)
  end

  def new(conn, _params) do
    changeset = Profiles.change_downvote(%Downvote{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"downvote" => downvote_params}) do
    case Profiles.create_downvote(downvote_params) do
      {:ok, downvote} ->
        conn
        |> put_flash(:info, "Downvote created successfully.")
        |> redirect(to: Routes.profiles_downvote_path(conn, :show, downvote))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    downvote = Profiles.get_downvote!(id)
    render(conn, "show.html", downvote: downvote)
  end

  def edit(conn, %{"id" => id}) do
    downvote = Profiles.get_downvote!(id)
    changeset = Profiles.change_downvote(downvote)
    render(conn, "edit.html", downvote: downvote, changeset: changeset)
  end

  def update(conn, %{"id" => id, "downvote" => downvote_params}) do
    downvote = Profiles.get_downvote!(id)

    case Profiles.update_downvote(downvote, downvote_params) do
      {:ok, downvote} ->
        conn
        |> put_flash(:info, "Downvote updated successfully.")
        |> redirect(to: Routes.profiles_downvote_path(conn, :show, downvote))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", downvote: downvote, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    downvote = Profiles.get_downvote!(id)
    {:ok, _downvote} = Profiles.delete_downvote(downvote)

    conn
    |> put_flash(:info, "Downvote deleted successfully.")
    |> redirect(to: Routes.profiles_downvote_path(conn, :index))
  end
end
