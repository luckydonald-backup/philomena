defmodule Philomena.Policy do
  def role?(user, name, resource_type) do
    !!(user.roles |> Enum.find(fn %{name: ^name, resource_type: ^resource_type} -> true; _ -> false end))
  end
end