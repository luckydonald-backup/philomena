defmodule PhilomenaWeb.Api.V2.TagView do
  use PhilomenaWeb, :view
  alias PhilomenaWeb.Api.V2.TagView

  def render("index.json", %{tags: tags}) do
    %{data: render_many(tags, TagView, "tag.json")}
  end

  def render("show.json", %{tag: tag}) do
    %{data: render_one(tag, TagView, "tag.json")}
  end

  def render("tag.json", %{tag: tag}) do
    %{id: tag.id}
  end
end
