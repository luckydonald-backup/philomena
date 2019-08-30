defmodule Philomena.Reports.Policy do
  @behaviour Bodyguard.Policy

  def authorize(_action, %{role: role}, _report) when role in ~W(admin moderator), do: true

  def authorize(:create, _user, _report), do: true
end
