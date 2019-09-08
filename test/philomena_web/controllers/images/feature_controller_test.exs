defmodule PhilomenaWeb.Images.FeatureControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Images

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:feature) do
    {:ok, feature} = Images.create_feature(@create_attrs)
    feature
  end

  describe "index" do
    test "lists all image_features", %{conn: conn} do
      conn = get(conn, Routes.images_feature_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Image features"
    end
  end

  describe "new feature" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.images_feature_path(conn, :new))
      assert html_response(conn, 200) =~ "New Feature"
    end
  end

  describe "create feature" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.images_feature_path(conn, :create), feature: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.images_feature_path(conn, :show, id)

      conn = get(conn, Routes.images_feature_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Feature"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.images_feature_path(conn, :create), feature: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Feature"
    end
  end

  describe "edit feature" do
    setup [:create_feature]

    test "renders form for editing chosen feature", %{conn: conn, feature: feature} do
      conn = get(conn, Routes.images_feature_path(conn, :edit, feature))
      assert html_response(conn, 200) =~ "Edit Feature"
    end
  end

  describe "update feature" do
    setup [:create_feature]

    test "redirects when data is valid", %{conn: conn, feature: feature} do
      conn = put(conn, Routes.images_feature_path(conn, :update, feature), feature: @update_attrs)
      assert redirected_to(conn) == Routes.images_feature_path(conn, :show, feature)

      conn = get(conn, Routes.images_feature_path(conn, :show, feature))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, feature: feature} do
      conn = put(conn, Routes.images_feature_path(conn, :update, feature), feature: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Feature"
    end
  end

  describe "delete feature" do
    setup [:create_feature]

    test "deletes chosen feature", %{conn: conn, feature: feature} do
      conn = delete(conn, Routes.images_feature_path(conn, :delete, feature))
      assert redirected_to(conn) == Routes.images_feature_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.images_feature_path(conn, :show, feature))
      end
    end
  end

  defp create_feature(_) do
    feature = fixture(:feature)
    {:ok, feature: feature}
  end
end
