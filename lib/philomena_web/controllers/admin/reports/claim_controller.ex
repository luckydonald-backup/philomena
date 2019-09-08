defmodule PhilomenaWeb.Admin.Reports.ClaimController do
  use PhilomenaWeb, :controller

  alias Philomena.Reports
  alias Philomena.Reports.Claim

  def index(conn, _params) do
    reports = Reports.list_reports()
    render(conn, "index.html", reports: reports)
  end

  def new(conn, _params) do
    changeset = Reports.change_claim(%Claim{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"claim" => claim_params}) do
    case Reports.create_claim(claim_params) do
      {:ok, claim} ->
        conn
        |> put_flash(:info, "Claim created successfully.")
        |> redirect(to: Routes.admin_reports_claim_path(conn, :show, claim))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    claim = Reports.get_claim!(id)
    render(conn, "show.html", claim: claim)
  end

  def edit(conn, %{"id" => id}) do
    claim = Reports.get_claim!(id)
    changeset = Reports.change_claim(claim)
    render(conn, "edit.html", claim: claim, changeset: changeset)
  end

  def update(conn, %{"id" => id, "claim" => claim_params}) do
    claim = Reports.get_claim!(id)

    case Reports.update_claim(claim, claim_params) do
      {:ok, claim} ->
        conn
        |> put_flash(:info, "Claim updated successfully.")
        |> redirect(to: Routes.admin_reports_claim_path(conn, :show, claim))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", claim: claim, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    claim = Reports.get_claim!(id)
    {:ok, _claim} = Reports.delete_claim(claim)

    conn
    |> put_flash(:info, "Claim deleted successfully.")
    |> redirect(to: Routes.admin_reports_claim_path(conn, :index))
  end
end
