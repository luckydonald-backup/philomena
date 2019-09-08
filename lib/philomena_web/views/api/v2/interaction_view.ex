defmodule PhilomenaWeb.Api.V2.InteractionView do
  use PhilomenaWeb, :view
  alias PhilomenaWeb.Api.V2.InteractionView

  def render("index.json", %{image_votes: image_votes}) do
    %{data: render_many(image_votes, InteractionView, "interaction.json")}
  end

  def render("show.json", %{interaction: interaction}) do
    %{data: render_one(interaction, InteractionView, "interaction.json")}
  end

  def render("interaction.json", %{interaction: interaction}) do
    %{id: interaction.id}
  end
end
