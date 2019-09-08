defmodule Philomena.Filters.Filter do
  use Ecto.Schema
  import Ecto.Changeset

  alias Philomena.Images.Query

  schema "filters" do
    belongs_to :user, Philomena.Users.User

    field :name, :string
    field :description, :string
    field :system, :boolean
    field :public, :boolean
    field :hidden_complex_str, :string
    field :spoilered_complex_str, :string
    field :hidden_tag_ids, {:array, :integer}, default: []
    field :spoilered_tag_ids, {:array, :integer}, default: []
    field :user_count, :integer, default: 0

    timestamps(inserted_at: :created_at)
  end

  @doc false
  def changeset(filter, attrs) do
    filter
    |> cast(attrs, [:spoilered_tag_list, :hidden_tag_list, :description, :name, :public, :spoilered_complex_str, :hidden_complex_str])
    |> validate_required([:name])
    |> validate_change(:spoilered_complex_str, &my_downvotes_validator/2)
    |> validate_change(:hidden_complex_str, &my_downvotes_validator/2)
    |> validate_change(:spoilered_complex_str, &query_validator/2)
    |> validate_change(:hidden_complex_str, &query_validator/2)
  end

  defp my_downvotes_validator(field, str) do
    if String.match?(str, ~r/my:downvotes/i) do
      [{field, "cannot contain my:downvotes"}]
    else
      []
    end
  end

  defp query_validator(field, str) do
    {:ok, tree} = Query.user_parser(%{user: nil}, str)

    true
  rescue
    _ ->
      false
  end
end
