defmodule Philomena.Topics.Policy do
  import Philomena.Policy

  @behaviour Bodyguard.Policy

  def authorize(_action, %{role: role}, _topic) when role in ~W(admin moderator), do: true

  def authorize(:read, user, topic) do
    (topic.hidden_from_users == false or topic_moderator?(user)) and
      Bodyguard.permit?(Philomena.Forums, :read, user, topic.forum)
  end

  def authorize(:create, user, topic) do
    Bodyguard.permit?(Philomena.Forums, :read, user, topic.forum)
  end

  def authorize(:lock, user, _topic), do: topic_moderator?(user)
  def authorize(:stick, user, _topic), do: topic_moderator?(user)
  def authorize(:hide, user, _topic), do: topic_moderator?(user)

  def authorize(_action, _user, _topic), do: false

  defp topic_moderator?(user), do: role?(user, "moderator", "Topic")
end
