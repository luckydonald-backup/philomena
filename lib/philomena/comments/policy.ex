defmodule Philomena.Comments.Policy do
  import Philomena.Policy

  @behaviour Bodyguard.Policy

  def authorize(_action, %{role: role}, _comment) when role in ~W(admin moderator), do: true

  def authorize(:read, user, comment) do
    (comment.image.hidden_from_users == false and comment.hidden_from_users == false) or
      comment_moderator?(user) or
      dupe_moderator?(user)
  end

  def authorize(:create, _user, comment) do
    comment.image.hidden_from_users == false
  end

  def authorize(:edit, user, comment) do
    (comment.hidden_from_users == false and comment.user_id == user.id and
       in_edit_window?(comment)) or
      comment_moderator?(user) or
      dupe_moderator?(user)
  end

  def authorize(:hide, user, _comment), do: comment_moderator?(user) or dupe_moderator?(user)
  def authorize(:restore, user, _comment), do: comment_moderator?(user) or dupe_moderator?(user)

  defp in_edit_window?(comment) do
    time_ago = NaiveDateTime.add(NaiveDateTime.utc_now(), -15 * 3600, :second)
    NaiveDateTime.compare(comment.created_at, time_ago) == :lt
  end

  defp comment_moderator?(user), do: role?(user, "moderator", "Comment")
  defp dupe_moderator?(user), do: role?(user, "moderator", "DuplicateReport")
end
