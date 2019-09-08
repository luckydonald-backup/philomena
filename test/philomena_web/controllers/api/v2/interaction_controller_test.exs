defmodule PhilomenaWeb.Api.V2.InteractionControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Images
  alias Philomena.Images.Interaction

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  def fixture(:interaction) do
    {:ok, interaction} = Images.create_interaction(@create_attrs)
    interaction
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all image_votes", %{conn: conn} do
      conn = get(conn, Routes.api_v2_interaction_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create interaction" do
    test "renders interaction when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_v2_interaction_path(conn, :create), interaction: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_v2_interaction_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_v2_interaction_path(conn, :create), interaction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update interaction" do
    setup [:create_interaction]

    test "renders interaction when data is valid", %{conn: conn, interaction: %Interaction{id: id} = interaction} do
      conn = put(conn, Routes.api_v2_interaction_path(conn, :update, interaction), interaction: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_v2_interaction_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, interaction: interaction} do
      conn = put(conn, Routes.api_v2_interaction_path(conn, :update, interaction), interaction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete interaction" do
    setup [:create_interaction]

    test "deletes chosen interaction", %{conn: conn, interaction: interaction} do
      conn = delete(conn, Routes.api_v2_interaction_path(conn, :delete, interaction))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_v2_interaction_path(conn, :show, interaction))
      end
    end
  end

  defp create_interaction(_) do
    interaction = fixture(:interaction)
    {:ok, interaction: interaction}
  end
end
