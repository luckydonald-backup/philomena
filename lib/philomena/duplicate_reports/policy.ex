defmodule Philomena.DuplicateReports.Policy do
  import Philomena.Policy

  @behaviour Bodyguard.Policy

  def authorize(_action, %{role: role}, _report) when role in ~W(admin moderator), do: true

  def authorize(:read, _user, _report), do: true
  def authorize(:create, _user, _report), do: true
  def authorize(:manage, user, _report), do: dupe_moderator?(user)

  defp dupe_moderator?(user), do: role?(user, "moderator", "DuplicateReport")
end
