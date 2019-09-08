defmodule PhilomenaWeb.Profiles.DetailController do
  use PhilomenaWeb, :controller

  alias Philomena.Profiles
  alias Philomena.Profiles.Detail

  def index(conn, _params) do
    details = Profiles.list_details()
    render(conn, "index.html", details: details)
  end

  def new(conn, _params) do
    changeset = Profiles.change_detail(%Detail{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"detail" => detail_params}) do
    case Profiles.create_detail(detail_params) do
      {:ok, detail} ->
        conn
        |> put_flash(:info, "Detail created successfully.")
        |> redirect(to: Routes.profiles_detail_path(conn, :show, detail))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    detail = Profiles.get_detail!(id)
    render(conn, "show.html", detail: detail)
  end

  def edit(conn, %{"id" => id}) do
    detail = Profiles.get_detail!(id)
    changeset = Profiles.change_detail(detail)
    render(conn, "edit.html", detail: detail, changeset: changeset)
  end

  def update(conn, %{"id" => id, "detail" => detail_params}) do
    detail = Profiles.get_detail!(id)

    case Profiles.update_detail(detail, detail_params) do
      {:ok, detail} ->
        conn
        |> put_flash(:info, "Detail updated successfully.")
        |> redirect(to: Routes.profiles_detail_path(conn, :show, detail))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", detail: detail, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    detail = Profiles.get_detail!(id)
    {:ok, _detail} = Profiles.delete_detail(detail)

    conn
    |> put_flash(:info, "Detail deleted successfully.")
    |> redirect(to: Routes.profiles_detail_path(conn, :index))
  end
end
