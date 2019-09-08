defmodule PhilomenaWeb.Api.V2.ImageView do
  use PhilomenaWeb, :view
  alias PhilomenaWeb.Api.V2.ImageView

  def render("index.json", %{images: images}) do
    %{data: render_many(images, ImageView, "image.json")}
  end

  def render("show.json", %{image: image}) do
    %{data: render_one(image, ImageView, "image.json")}
  end

  def render("image.json", %{image: image}) do
    %{id: image.id}
  end
end
