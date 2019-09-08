defmodule PhilomenaWeb.CommissionController do
  use PhilomenaWeb, :controller

  alias Philomena.Commissions
  alias Philomena.Commissions.Commission

  def index(conn, _params) do
    commissions = Commissions.list_commissions()
    render(conn, "index.html", commissions: commissions)
  end

  def new(conn, _params) do
    changeset = Commissions.change_commission(%Commission{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"commission" => commission_params}) do
    case Commissions.create_commission(commission_params) do
      {:ok, commission} ->
        conn
        |> put_flash(:info, "Commission created successfully.")
        |> redirect(to: Routes.commission_path(conn, :show, commission))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    commission = Commissions.get_commission!(id)
    render(conn, "show.html", commission: commission)
  end

  def edit(conn, %{"id" => id}) do
    commission = Commissions.get_commission!(id)
    changeset = Commissions.change_commission(commission)
    render(conn, "edit.html", commission: commission, changeset: changeset)
  end

  def update(conn, %{"id" => id, "commission" => commission_params}) do
    commission = Commissions.get_commission!(id)

    case Commissions.update_commission(commission, commission_params) do
      {:ok, commission} ->
        conn
        |> put_flash(:info, "Commission updated successfully.")
        |> redirect(to: Routes.commission_path(conn, :show, commission))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", commission: commission, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    commission = Commissions.get_commission!(id)
    {:ok, _commission} = Commissions.delete_commission(commission)

    conn
    |> put_flash(:info, "Commission deleted successfully.")
    |> redirect(to: Routes.commission_path(conn, :index))
  end
end
