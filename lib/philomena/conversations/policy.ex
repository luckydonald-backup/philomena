defmodule Philomena.Conversations.Policy do
  @behaviour Bodyguard.Policy

  def authorize(_action, %{role: role}, _conversation) when role in ~W(admin moderator), do: true

  def authorize(:read, user, conversation) do
    user.id in [conversation.from_id, conversation.to_id]
  end

  def authorize(_action, _user, _conversation), do: false
end
