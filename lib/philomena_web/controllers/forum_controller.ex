defmodule PhilomenaWeb.ForumController do
  use PhilomenaWeb, :controller

  alias Philomena.{Forums, Forums.Forum, Repo}

  def index(conn, _params) do
    forums = Forums.list_forums(current_user(conn))
    render(conn, "index.html", forums: forums)
  end

  def show(conn, %{"id" => id}) do
    forum = Forums.get_forum!(current_user(conn), id)
    render(conn, "show.html", forum: forum)
  end
end
