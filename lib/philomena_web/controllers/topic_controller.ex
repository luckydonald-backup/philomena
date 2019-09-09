defmodule PhilomenaWeb.TopicController do
  use PhilomenaWeb, :controller

  alias Philomena.{Forums, Topics, Topics.Topic, Repo}
  import Ecto, only: [build_assoc: 3]

  def new(conn, %{"forum_id" => forum_id}) do
    forum = Forums.get_forum!(current_user(conn), forum_id)
    changeset = Topics.change_topic(build_assoc(forum, :topics))

    with :ok <- Bodyguard.permit(Topic, :create, user, changeset) do
      render(conn, "new.html", changeset: changeset)
    end
  end

  def create(conn, %{"forum_id" => forum_id, "topic" => topic_params}) do
    forum = Forums.get_forum!(current_user(conn), forum_id)
    changeset = build_assoc(forum, :topics) |> Topic.changeset(topic_params)

    with :ok <- Bodyguard.permit(Topic, :create, current_user(conn), changeset) do
      case Repo.insert(changeset) do
        {:ok, topic} ->
          conn
          |> put_flash(:info, "Topic created successfully.")
          |> redirect(to: Routes.forum_topic_path(conn, :show, forum, topic))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"forum_id" => forum_id, "id" => id}) do
    forum = Forums.get_forum!(current_user(conn), forum_id)
    topic = Topics.get_topic!(forum, id)

    render(conn, "show.html", topic: topic)
  end
end
