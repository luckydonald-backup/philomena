defmodule PhilomenaWeb.Images.DescriptionControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Images

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:description) do
    {:ok, description} = Images.create_description(@create_attrs)
    description
  end

  describe "index" do
    test "lists all descriptions", %{conn: conn} do
      conn = get(conn, Routes.images_description_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Descriptions"
    end
  end

  describe "new description" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.images_description_path(conn, :new))
      assert html_response(conn, 200) =~ "New Description"
    end
  end

  describe "create description" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.images_description_path(conn, :create), description: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.images_description_path(conn, :show, id)

      conn = get(conn, Routes.images_description_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Description"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.images_description_path(conn, :create), description: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Description"
    end
  end

  describe "edit description" do
    setup [:create_description]

    test "renders form for editing chosen description", %{conn: conn, description: description} do
      conn = get(conn, Routes.images_description_path(conn, :edit, description))
      assert html_response(conn, 200) =~ "Edit Description"
    end
  end

  describe "update description" do
    setup [:create_description]

    test "redirects when data is valid", %{conn: conn, description: description} do
      conn = put(conn, Routes.images_description_path(conn, :update, description), description: @update_attrs)
      assert redirected_to(conn) == Routes.images_description_path(conn, :show, description)

      conn = get(conn, Routes.images_description_path(conn, :show, description))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, description: description} do
      conn = put(conn, Routes.images_description_path(conn, :update, description), description: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Description"
    end
  end

  describe "delete description" do
    setup [:create_description]

    test "deletes chosen description", %{conn: conn, description: description} do
      conn = delete(conn, Routes.images_description_path(conn, :delete, description))
      assert redirected_to(conn) == Routes.images_description_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.images_description_path(conn, :show, description))
      end
    end
  end

  defp create_description(_) do
    description = fixture(:description)
    {:ok, description: description}
  end
end
