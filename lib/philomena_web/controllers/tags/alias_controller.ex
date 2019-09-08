defmodule PhilomenaWeb.Tags.AliasController do
  use PhilomenaWeb, :controller

  alias Philomena.Tags
  alias Philomena.Tags.Alias

  def index(conn, _params) do
    aliases = Tags.list_aliases()
    render(conn, "index.html", aliases: aliases)
  end

  def new(conn, _params) do
    changeset = Tags.change_alias(%Alias{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"alias" => alias_params}) do
    case Tags.create_alias(alias_params) do
      {:ok, alias} ->
        conn
        |> put_flash(:info, "Alias created successfully.")
        |> redirect(to: Routes.tags_alias_path(conn, :show, alias))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    alias = Tags.get_alias!(id)
    render(conn, "show.html", alias: alias)
  end

  def edit(conn, %{"id" => id}) do
    alias = Tags.get_alias!(id)
    changeset = Tags.change_alias(alias)
    render(conn, "edit.html", alias: alias, changeset: changeset)
  end

  def update(conn, %{"id" => id, "alias" => alias_params}) do
    alias = Tags.get_alias!(id)

    case Tags.update_alias(alias, alias_params) do
      {:ok, alias} ->
        conn
        |> put_flash(:info, "Alias updated successfully.")
        |> redirect(to: Routes.tags_alias_path(conn, :show, alias))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", alias: alias, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    alias = Tags.get_alias!(id)
    {:ok, _alias} = Tags.delete_alias(alias)

    conn
    |> put_flash(:info, "Alias deleted successfully.")
    |> redirect(to: Routes.tags_alias_path(conn, :index))
  end
end
