defmodule PhilomenaWeb.Images.RepairControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Images

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:repair) do
    {:ok, repair} = Images.create_repair(@create_attrs)
    repair
  end

  describe "index" do
    test "lists all repairs", %{conn: conn} do
      conn = get(conn, Routes.images_repair_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Repairs"
    end
  end

  describe "new repair" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.images_repair_path(conn, :new))
      assert html_response(conn, 200) =~ "New Repair"
    end
  end

  describe "create repair" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.images_repair_path(conn, :create), repair: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.images_repair_path(conn, :show, id)

      conn = get(conn, Routes.images_repair_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Repair"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.images_repair_path(conn, :create), repair: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Repair"
    end
  end

  describe "edit repair" do
    setup [:create_repair]

    test "renders form for editing chosen repair", %{conn: conn, repair: repair} do
      conn = get(conn, Routes.images_repair_path(conn, :edit, repair))
      assert html_response(conn, 200) =~ "Edit Repair"
    end
  end

  describe "update repair" do
    setup [:create_repair]

    test "redirects when data is valid", %{conn: conn, repair: repair} do
      conn = put(conn, Routes.images_repair_path(conn, :update, repair), repair: @update_attrs)
      assert redirected_to(conn) == Routes.images_repair_path(conn, :show, repair)

      conn = get(conn, Routes.images_repair_path(conn, :show, repair))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, repair: repair} do
      conn = put(conn, Routes.images_repair_path(conn, :update, repair), repair: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Repair"
    end
  end

  describe "delete repair" do
    setup [:create_repair]

    test "deletes chosen repair", %{conn: conn, repair: repair} do
      conn = delete(conn, Routes.images_repair_path(conn, :delete, repair))
      assert redirected_to(conn) == Routes.images_repair_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.images_repair_path(conn, :show, repair))
      end
    end
  end

  defp create_repair(_) do
    repair = fixture(:repair)
    {:ok, repair: repair}
  end
end
