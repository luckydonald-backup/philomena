defmodule PhilomenaWeb.FilterController do
  use PhilomenaWeb, :controller

  alias Philomena.Filters
  alias Philomena.Filters.Filter

  def index(conn, _params) do
    filters = Filters.list_filters()
    render(conn, "index.html", filters: filters, title: "Filters")
  end

  def new(conn, %{"based_on_filter_id" => filter_id}) do
    filter = Filters.get_filter!(filter_id)
    changeset = Filters.change_filter(%{filter | id: nil})

    with :ok <- Bodyguard.permit(Filter, :read, current_user(conn), filter),
         :ok <- Bodyguard.permit(Filter, :create, current_user(conn), nil)
    do
      render(conn, "new.html", changeset: changeset, title: "New Filter")
    end
  end

  def new(conn, _params) do
    changeset = Filters.change_filter(%Filter{})

    with :ok <- Bodyguard.permit(Filter, :create, current_user(conn), nil) do
      render(conn, "new.html", changeset: changeset, title: "New Filter")
    end
  end

  def create(conn, %{"filter" => filter_params}) do
    case Filters.create_filter(current_user(conn), filter_params) do
      {:ok, filter} ->
        conn
        |> put_flash(:info, "Filter created successfully.")
        |> redirect(to: Routes.filter_path(conn, :show, filter))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    filter = Filters.get_filter!(id)

    with :ok <- Bodyguard.permit(Filter, :read, current_user(conn), filter) do
      render(conn, "show.html", filter: filter, title: "#{filter.name} - Filters")
    end
  end

  def edit(conn, %{"id" => id}) do
    filter = Filters.get_filter!(id)
    changeset = Filters.change_filter(filter)

    with :ok <- Bodyguard.permit(Filter, :edit, current_user(conn), filter) do
      render(conn, "edit.html", filter: filter, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "filter" => filter_params}) do
    filter = Filters.get_filter!(id)

    with :ok <- Bodyguard.permit(Filter, :edit, current_user(conn), filter) do
      case Filters.update_filter(filter, filter_params) do
        {:ok, filter} ->
          conn
          |> put_flash(:info, "Filter updated successfully.")
          |> redirect(to: Routes.filter_path(conn, :show, filter))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", filter: filter, changeset: changeset)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    filter = Filters.get_filter!(id)

    with :ok <- Bodyguard.permit(Filter, :delete, current_user(conn), filter) do
      {:ok, _filter} = Filters.delete_filter(filter)

      conn
      |> put_flash(:info, "Filter deleted successfully.")
      |> redirect(to: Routes.filter_path(conn, :index))
    end
  end
end
