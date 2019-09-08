defmodule PhilomenaWeb.Galleries.RandomController do
  use PhilomenaWeb, :controller

  alias Philomena.Galleries
  alias Philomena.Galleries.Random

  def index(conn, _params) do
    random = Galleries.list_random()
    render(conn, "index.html", random: random)
  end

  def new(conn, _params) do
    changeset = Galleries.change_random(%Random{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"random" => random_params}) do
    case Galleries.create_random(random_params) do
      {:ok, random} ->
        conn
        |> put_flash(:info, "Random created successfully.")
        |> redirect(to: Routes.galleries_random_path(conn, :show, random))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    random = Galleries.get_random!(id)
    render(conn, "show.html", random: random)
  end

  def edit(conn, %{"id" => id}) do
    random = Galleries.get_random!(id)
    changeset = Galleries.change_random(random)
    render(conn, "edit.html", random: random, changeset: changeset)
  end

  def update(conn, %{"id" => id, "random" => random_params}) do
    random = Galleries.get_random!(id)

    case Galleries.update_random(random, random_params) do
      {:ok, random} ->
        conn
        |> put_flash(:info, "Random updated successfully.")
        |> redirect(to: Routes.galleries_random_path(conn, :show, random))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", random: random, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    random = Galleries.get_random!(id)
    {:ok, _random} = Galleries.delete_random(random)

    conn
    |> put_flash(:info, "Random deleted successfully.")
    |> redirect(to: Routes.galleries_random_path(conn, :index))
  end
end
