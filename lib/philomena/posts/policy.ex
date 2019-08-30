defmodule Philomena.Posts.Policy do
  import Philomena.Policy

  @behaviour Bodyguard.Policy

  def authorize(_action, %{role: role}, _post) when role in ~W(admin moderator), do: true

  def authorize(:read, user, post) do
    (post.hidden_from_users == false or topic_moderator?(user)) and
      Bodyguard.permit?(Philomena.Topics, :read, user, post.topic)
  end

  def authorize(:create, user, post) do
    Bodyguard.permit?(Philomena.Topics, :read, user, post.topic)
  end

  def authorize(:hide, user, _post), do: topic_moderator?(user)
  def authorize(:edit, user, post), do: post.user_id == user.id or topic_moderator?(user)

  def authorize(_action, _user, _topic), do: false

  defp topic_moderator?(user), do: role?(user, "moderator", "Topic")
end
