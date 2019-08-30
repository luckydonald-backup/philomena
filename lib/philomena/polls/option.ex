defmodule Philomena.Polls.Option do
  use Ecto.Schema
  import Ecto.Changeset

  schema "poll_options" do
    belongs_to :poll, Philomena.Polls.Poll

    field :label, :string
    field :vote_count, :integer, default: 0
  end

  @doc false
  def changeset(option, attrs) do
    option
    |> cast(attrs, [])
    |> validate_required([])
  end
end
