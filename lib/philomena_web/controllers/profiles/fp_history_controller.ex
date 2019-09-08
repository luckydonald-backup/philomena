defmodule PhilomenaWeb.Profiles.FpHistoryController do
  use PhilomenaWeb, :controller

  alias Philomena.Profiles
  alias Philomena.Profiles.FpHistory

  def index(conn, _params) do
    fp_histories = Profiles.list_fp_histories()
    render(conn, "index.html", fp_histories: fp_histories)
  end

  def new(conn, _params) do
    changeset = Profiles.change_fp_history(%FpHistory{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"fp_history" => fp_history_params}) do
    case Profiles.create_fp_history(fp_history_params) do
      {:ok, fp_history} ->
        conn
        |> put_flash(:info, "Fp history created successfully.")
        |> redirect(to: Routes.profiles_fp_history_path(conn, :show, fp_history))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    fp_history = Profiles.get_fp_history!(id)
    render(conn, "show.html", fp_history: fp_history)
  end

  def edit(conn, %{"id" => id}) do
    fp_history = Profiles.get_fp_history!(id)
    changeset = Profiles.change_fp_history(fp_history)
    render(conn, "edit.html", fp_history: fp_history, changeset: changeset)
  end

  def update(conn, %{"id" => id, "fp_history" => fp_history_params}) do
    fp_history = Profiles.get_fp_history!(id)

    case Profiles.update_fp_history(fp_history, fp_history_params) do
      {:ok, fp_history} ->
        conn
        |> put_flash(:info, "Fp history updated successfully.")
        |> redirect(to: Routes.profiles_fp_history_path(conn, :show, fp_history))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", fp_history: fp_history, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    fp_history = Profiles.get_fp_history!(id)
    {:ok, _fp_history} = Profiles.delete_fp_history(fp_history)

    conn
    |> put_flash(:info, "Fp history deleted successfully.")
    |> redirect(to: Routes.profiles_fp_history_path(conn, :index))
  end
end
