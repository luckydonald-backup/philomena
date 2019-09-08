defmodule PhilomenaWeb.OembedController do
  use PhilomenaWeb, :controller

  alias Philomena.Oembeds
  alias Philomena.Oembeds.Oembed

  def index(conn, _params) do
    oembeds = Oembeds.list_oembeds()
    render(conn, "index.html", oembeds: oembeds)
  end

  def new(conn, _params) do
    changeset = Oembeds.change_oembed(%Oembed{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"oembed" => oembed_params}) do
    case Oembeds.create_oembed(oembed_params) do
      {:ok, oembed} ->
        conn
        |> put_flash(:info, "Oembed created successfully.")
        |> redirect(to: Routes.oembed_path(conn, :show, oembed))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    oembed = Oembeds.get_oembed!(id)
    render(conn, "show.html", oembed: oembed)
  end

  def edit(conn, %{"id" => id}) do
    oembed = Oembeds.get_oembed!(id)
    changeset = Oembeds.change_oembed(oembed)
    render(conn, "edit.html", oembed: oembed, changeset: changeset)
  end

  def update(conn, %{"id" => id, "oembed" => oembed_params}) do
    oembed = Oembeds.get_oembed!(id)

    case Oembeds.update_oembed(oembed, oembed_params) do
      {:ok, oembed} ->
        conn
        |> put_flash(:info, "Oembed updated successfully.")
        |> redirect(to: Routes.oembed_path(conn, :show, oembed))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", oembed: oembed, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    oembed = Oembeds.get_oembed!(id)
    {:ok, _oembed} = Oembeds.delete_oembed(oembed)

    conn
    |> put_flash(:info, "Oembed deleted successfully.")
    |> redirect(to: Routes.oembed_path(conn, :index))
  end
end
