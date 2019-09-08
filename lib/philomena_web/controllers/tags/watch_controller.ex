defmodule PhilomenaWeb.Tags.WatchController do
  use PhilomenaWeb, :controller

  alias Philomena.Tags
  alias Philomena.Tags.Watch

  def index(conn, _params) do
    watches = Tags.list_watches()
    render(conn, "index.html", watches: watches)
  end

  def new(conn, _params) do
    changeset = Tags.change_watch(%Watch{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"watch" => watch_params}) do
    case Tags.create_watch(watch_params) do
      {:ok, watch} ->
        conn
        |> put_flash(:info, "Watch created successfully.")
        |> redirect(to: Routes.tags_watch_path(conn, :show, watch))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    watch = Tags.get_watch!(id)
    render(conn, "show.html", watch: watch)
  end

  def edit(conn, %{"id" => id}) do
    watch = Tags.get_watch!(id)
    changeset = Tags.change_watch(watch)
    render(conn, "edit.html", watch: watch, changeset: changeset)
  end

  def update(conn, %{"id" => id, "watch" => watch_params}) do
    watch = Tags.get_watch!(id)

    case Tags.update_watch(watch, watch_params) do
      {:ok, watch} ->
        conn
        |> put_flash(:info, "Watch updated successfully.")
        |> redirect(to: Routes.tags_watch_path(conn, :show, watch))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", watch: watch, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    watch = Tags.get_watch!(id)
    {:ok, _watch} = Tags.delete_watch(watch)

    conn
    |> put_flash(:info, "Watch deleted successfully.")
    |> redirect(to: Routes.tags_watch_path(conn, :index))
  end
end
