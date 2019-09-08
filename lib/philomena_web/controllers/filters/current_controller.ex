defmodule PhilomenaWeb.Filters.CurrentController do
  use PhilomenaWeb, :controller

  alias Philomena.{Filters, Users}

  def show(conn, _params) do
    conn
    |> redirect(to: Routes.filter_path(conn, :show, conn.assigns[:current_filter].id))
  end

  def update(conn, %{"id" => id}) do
    filter = Filters.get_filter!(id)
    user = current_user(conn)

    with :ok <- Bodyguard.permit(Filter, :read, user, filter),
         conn <- set_filter(conn, user, filter.id)
    do
      conn
      |> put_flash(:info, "Filter updated successfully.")
      |> redirect(to: Routes.filters_path(conn, :index))
    else
      _ ->
        conn
        |> put_flash(:error, "Failed to set filter!")
        |> redirect(to: Routes.filters_path(conn, :index))
    end
  end

  defp set_filter(conn, nil, filter_id) do
    conn |> put_session(:filter_id, filter_id)
  end

  defp set_filter(conn, user, filter_id) do
    user |> Users.update_user(%{current_filter_id: filter_id})

    conn
  end
end
