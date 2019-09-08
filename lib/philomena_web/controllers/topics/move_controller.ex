defmodule PhilomenaWeb.Topics.MoveController do
  use PhilomenaWeb, :controller

  alias Philomena.Topics
  alias Philomena.Topics.Move

  def index(conn, _params) do
    moves = Topics.list_moves()
    render(conn, "index.html", moves: moves)
  end

  def new(conn, _params) do
    changeset = Topics.change_move(%Move{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"move" => move_params}) do
    case Topics.create_move(move_params) do
      {:ok, move} ->
        conn
        |> put_flash(:info, "Move created successfully.")
        |> redirect(to: Routes.topics_move_path(conn, :show, move))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    move = Topics.get_move!(id)
    render(conn, "show.html", move: move)
  end

  def edit(conn, %{"id" => id}) do
    move = Topics.get_move!(id)
    changeset = Topics.change_move(move)
    render(conn, "edit.html", move: move, changeset: changeset)
  end

  def update(conn, %{"id" => id, "move" => move_params}) do
    move = Topics.get_move!(id)

    case Topics.update_move(move, move_params) do
      {:ok, move} ->
        conn
        |> put_flash(:info, "Move updated successfully.")
        |> redirect(to: Routes.topics_move_path(conn, :show, move))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", move: move, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    move = Topics.get_move!(id)
    {:ok, _move} = Topics.delete_move(move)

    conn
    |> put_flash(:info, "Move deleted successfully.")
    |> redirect(to: Routes.topics_move_path(conn, :index))
  end
end
