defmodule PhilomenaWeb.Topics.Posts.HideController do
  use PhilomenaWeb, :controller

  alias Philomena.Topics
  alias Philomena.Topics.Hide

  def index(conn, _params) do
    hides = Topics.list_hides()
    render(conn, "index.html", hides: hides)
  end

  def new(conn, _params) do
    changeset = Topics.change_hide(%Hide{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"hide" => hide_params}) do
    case Topics.create_hide(hide_params) do
      {:ok, hide} ->
        conn
        |> put_flash(:info, "Hide created successfully.")
        |> redirect(to: Routes.topics_posts_hide_path(conn, :show, hide))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    hide = Topics.get_hide!(id)
    render(conn, "show.html", hide: hide)
  end

  def edit(conn, %{"id" => id}) do
    hide = Topics.get_hide!(id)
    changeset = Topics.change_hide(hide)
    render(conn, "edit.html", hide: hide, changeset: changeset)
  end

  def update(conn, %{"id" => id, "hide" => hide_params}) do
    hide = Topics.get_hide!(id)

    case Topics.update_hide(hide, hide_params) do
      {:ok, hide} ->
        conn
        |> put_flash(:info, "Hide updated successfully.")
        |> redirect(to: Routes.topics_posts_hide_path(conn, :show, hide))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", hide: hide, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    hide = Topics.get_hide!(id)
    {:ok, _hide} = Topics.delete_hide(hide)

    conn
    |> put_flash(:info, "Hide deleted successfully.")
    |> redirect(to: Routes.topics_posts_hide_path(conn, :index))
  end
end
