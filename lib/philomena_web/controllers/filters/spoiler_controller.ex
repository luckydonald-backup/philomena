defmodule PhilomenaWeb.Filters.SpoilerController do
  use PhilomenaWeb, :controller

  alias Philomena.{Filters, Tags}

  def create(conn, %{"tagname" => tagname}) do
    filter = conn.assigns[:current_filter]
    tag = Tags.get_by_slug_or_id!(tagname)
    user = current_user(conn)

    with :ok <- Bodyguard.permit(Filter, :edit, user, filter) do
      filter
      |> Filters.update_filter(%{spoilered_tag_ids: [tag.id | filter.spoilered_tag_ids]})

      conn
      |> put_flash(:info, "Tag successfully hidden.")
      |> redirect(to: Routes.filters_path(conn, :index))
    end
  end

  def delete(conn, %{"tagname" => tagname}) do
    filter = conn.assigns[:current_filter]
    tag = Tags.get_by_slug_or_id!(tagname)
    user = current_user(conn)

    with :ok <- Bodyguard.permit(Filter, :edit, user, filter) do
      filter
      |> Filters.update_filter(%{spoilered_tag_ids: List.delete(filter.spoilered_tag_ids, tag.id)})

      conn
      |> put_flash(:info, "Tag successfully hidden.")
      |> redirect(to: Routes.filters_path(conn, :index))
    end
  end
end
