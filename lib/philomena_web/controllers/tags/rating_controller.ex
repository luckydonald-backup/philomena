defmodule PhilomenaWeb.Tags.RatingController do
  use PhilomenaWeb, :controller

  alias Philomena.Tags
  alias Philomena.Tags.Rating

  def index(conn, _params) do
    ratings = Tags.list_ratings()
    render(conn, "index.html", ratings: ratings)
  end

  def new(conn, _params) do
    changeset = Tags.change_rating(%Rating{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"rating" => rating_params}) do
    case Tags.create_rating(rating_params) do
      {:ok, rating} ->
        conn
        |> put_flash(:info, "Rating created successfully.")
        |> redirect(to: Routes.tags_rating_path(conn, :show, rating))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    rating = Tags.get_rating!(id)
    render(conn, "show.html", rating: rating)
  end

  def edit(conn, %{"id" => id}) do
    rating = Tags.get_rating!(id)
    changeset = Tags.change_rating(rating)
    render(conn, "edit.html", rating: rating, changeset: changeset)
  end

  def update(conn, %{"id" => id, "rating" => rating_params}) do
    rating = Tags.get_rating!(id)

    case Tags.update_rating(rating, rating_params) do
      {:ok, rating} ->
        conn
        |> put_flash(:info, "Rating updated successfully.")
        |> redirect(to: Routes.tags_rating_path(conn, :show, rating))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", rating: rating, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    rating = Tags.get_rating!(id)
    {:ok, _rating} = Tags.delete_rating(rating)

    conn
    |> put_flash(:info, "Rating deleted successfully.")
    |> redirect(to: Routes.tags_rating_path(conn, :index))
  end
end
