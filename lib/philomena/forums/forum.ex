defmodule Philomena.Forums.Forum do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  @behaviour Bodyguard.Schema

  schema "forums" do
    belongs_to :last_post, Philomena.Posts.Post
    belongs_to :last_topic, Philomena.Topics.Topic

    field :name, :string
    field :short_name, :string
    field :description, :string
    field :access_level, :string, default: "normal"
    field :topic_count, :integer, default: 0
    field :post_count, :integer, default: 0

    timestamps(inserted_at: :created_at)
  end

  @doc false
  def changeset(forum, attrs) do
    forum
    |> cast(attrs, [])
    |> validate_required([])
  end

  def scope(query, %{role: role}, _forum) when role in ~W(admin moderator), do: query
  def scope(query, %{role: "assistant"}, _forum), do: query |> where([f], f.access_level in ~W(normal assistant))
  def scope(query, %{role: _role}, _forum), do:  query |> where(access_level: "normal")
end
