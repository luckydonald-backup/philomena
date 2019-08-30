defmodule Philomena.DnpEntries.Policy do
  @behaviour Bodyguard.Policy

  def authorize(_action, %{role: role}, _entry) when role in ~W(admin moderator), do: true

  def authorize(:read, user, entry), do: entry.listed or user.id == entry.requesting_user.id
end
