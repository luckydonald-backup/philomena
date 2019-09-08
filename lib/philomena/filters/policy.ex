defmodule Philomena.Filters.Policy do
  @behaviour Bodyguard.Policy

  def authorize(_action, %{role: role}, _filter) when role in ~W(admin moderator), do: true

  def authorize(:read, user, filter) do
    filter.system or filter.public or user.id == filter.user_id
  end

  def authorize(:create, _user, _filter), do: true

  def authorize(:edit, user, filter) do
    !!filter.user_id and filter.user_id == user.id
  end

  def authorize(:destroy, user, filter) do
    !!filter.user_id and filter.user_id == user.id and filter.user_count == 0
  end

  def authorize(_action, _user, _filter), do: false
end
