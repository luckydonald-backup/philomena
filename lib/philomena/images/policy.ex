defmodule Philomena.Images.Policy do
  import Philomena.Policy

  @behaviour Bodyguard.Policy

  def authorize(_action, %{role: role}, _image) when role in ~W(admin moderator), do: true

  def authorize(:read, user, image) do
    image.hidden_from_users == false or image_moderator?(user)
  end

  def authorize(:update, user, image) do
    (image.hidden_from_users == false and image.user_id == user.id) or image_moderator?(user) or dupe_moderator?(user)
  end

  def authorize(:update_metadata, user, image), do: authorize(:read, user, image) and image.tag_editing_allowed
  def authorize(:hide, user, _image), do: image_moderator?(user)
  def authorize(:undelete, user, _image), do: image_moderator?(user)
  def authorize(:repair, user, _image), do: image_moderator?(user)
  def authorize(:edit_scratchpad, user, _image), do: image_moderator?(user)

  defp image_moderator?(user), do: role?(user, "moderator", "Image")
  defp dupe_moderator?(user), do: role?(user, "moderator", "DuplicateReport")
end