defmodule Philomena.StaticPages.Version do
  use Ecto.Schema
  import Ecto.Changeset

  schema "static_page_versions" do
    belongs_to :user, Philomena.Users.User
    belongs_to :static_page, Philomena.StaticPages.StaticPage

    field :title, :string
    field :slug, :string
    field :body, :string

    timestamps(inserted_at: :created_at)
  end

  @doc false
  def changeset(version, attrs) do
    version
    |> cast(attrs, [])
    |> validate_required([])
  end
end
