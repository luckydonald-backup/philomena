defmodule Philomena.Forums.Policy do
  @behaviour Bodyguard.Policy

  def authorize(_action, %{role: role}, _forum) when role in ~W(admin moderator), do: true

  def authorize(:read, %{role: "user"}, %{access_level: level}) when level in ~W(normal), do: true

  def authorize(:read, %{role: "assistant"}, %{access_level: level})
      when level in ~W(normal assistant),
      do: true

  def authorize(:read, _user, _forum), do: false
end
