defmodule PhilomenaWeb.Tags.AutocompleteController do
  use PhilomenaWeb, :controller

  alias Philomena.Tags
  alias Philomena.Tags.Autocomplete

  def index(conn, _params) do
    autocomplete = Tags.list_autocomplete()
    render(conn, "index.html", autocomplete: autocomplete)
  end

  def new(conn, _params) do
    changeset = Tags.change_autocomplete(%Autocomplete{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"autocomplete" => autocomplete_params}) do
    case Tags.create_autocomplete(autocomplete_params) do
      {:ok, autocomplete} ->
        conn
        |> put_flash(:info, "Autocomplete created successfully.")
        |> redirect(to: Routes.tags_autocomplete_path(conn, :show, autocomplete))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    autocomplete = Tags.get_autocomplete!(id)
    render(conn, "show.html", autocomplete: autocomplete)
  end

  def edit(conn, %{"id" => id}) do
    autocomplete = Tags.get_autocomplete!(id)
    changeset = Tags.change_autocomplete(autocomplete)
    render(conn, "edit.html", autocomplete: autocomplete, changeset: changeset)
  end

  def update(conn, %{"id" => id, "autocomplete" => autocomplete_params}) do
    autocomplete = Tags.get_autocomplete!(id)

    case Tags.update_autocomplete(autocomplete, autocomplete_params) do
      {:ok, autocomplete} ->
        conn
        |> put_flash(:info, "Autocomplete updated successfully.")
        |> redirect(to: Routes.tags_autocomplete_path(conn, :show, autocomplete))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", autocomplete: autocomplete, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    autocomplete = Tags.get_autocomplete!(id)
    {:ok, _autocomplete} = Tags.delete_autocomplete(autocomplete)

    conn
    |> put_flash(:info, "Autocomplete deleted successfully.")
    |> redirect(to: Routes.tags_autocomplete_path(conn, :index))
  end
end
