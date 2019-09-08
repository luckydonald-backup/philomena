defmodule PhilomenaWeb.Search.SyntaxController do
  use PhilomenaWeb, :controller

  alias Philomena.Search
  alias Philomena.Search.Syntax

  def index(conn, _params) do
    syntax = Search.list_syntax()
    render(conn, "index.html", syntax: syntax)
  end

  def new(conn, _params) do
    changeset = Search.change_syntax(%Syntax{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"syntax" => syntax_params}) do
    case Search.create_syntax(syntax_params) do
      {:ok, syntax} ->
        conn
        |> put_flash(:info, "Syntax created successfully.")
        |> redirect(to: Routes.search_syntax_path(conn, :show, syntax))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    syntax = Search.get_syntax!(id)
    render(conn, "show.html", syntax: syntax)
  end

  def edit(conn, %{"id" => id}) do
    syntax = Search.get_syntax!(id)
    changeset = Search.change_syntax(syntax)
    render(conn, "edit.html", syntax: syntax, changeset: changeset)
  end

  def update(conn, %{"id" => id, "syntax" => syntax_params}) do
    syntax = Search.get_syntax!(id)

    case Search.update_syntax(syntax, syntax_params) do
      {:ok, syntax} ->
        conn
        |> put_flash(:info, "Syntax updated successfully.")
        |> redirect(to: Routes.search_syntax_path(conn, :show, syntax))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", syntax: syntax, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    syntax = Search.get_syntax!(id)
    {:ok, _syntax} = Search.delete_syntax(syntax)

    conn
    |> put_flash(:info, "Syntax deleted successfully.")
    |> redirect(to: Routes.search_syntax_path(conn, :index))
  end
end
