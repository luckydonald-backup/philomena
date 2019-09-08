defmodule PhilomenaWeb.Api.V2.InteractionController do
  use PhilomenaWeb, :controller

  alias Philomena.Images
  alias Philomena.Images.Interaction

  action_fallback PhilomenaWeb.FallbackController

  def index(conn, _params) do
    image_votes = Images.list_image_votes()
    render(conn, "index.json", image_votes: image_votes)
  end

  def create(conn, %{"interaction" => interaction_params}) do
    with {:ok, %Interaction{} = interaction} <- Images.create_interaction(interaction_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_v2_interaction_path(conn, :show, interaction))
      |> render("show.json", interaction: interaction)
    end
  end

  def show(conn, %{"id" => id}) do
    interaction = Images.get_interaction!(id)
    render(conn, "show.json", interaction: interaction)
  end

  def update(conn, %{"id" => id, "interaction" => interaction_params}) do
    interaction = Images.get_interaction!(id)

    with {:ok, %Interaction{} = interaction} <- Images.update_interaction(interaction, interaction_params) do
      render(conn, "show.json", interaction: interaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    interaction = Images.get_interaction!(id)

    with {:ok, %Interaction{}} <- Images.delete_interaction(interaction) do
      send_resp(conn, :no_content, "")
    end
  end
end
