defmodule PhilomenaWeb.Tags.UsageControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Tags

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:usage) do
    {:ok, usage} = Tags.create_usage(@create_attrs)
    usage
  end

  describe "index" do
    test "lists all usage", %{conn: conn} do
      conn = get(conn, Routes.tags_usage_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Usage"
    end
  end

  describe "new usage" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.tags_usage_path(conn, :new))
      assert html_response(conn, 200) =~ "New Usage"
    end
  end

  describe "create usage" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.tags_usage_path(conn, :create), usage: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.tags_usage_path(conn, :show, id)

      conn = get(conn, Routes.tags_usage_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Usage"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.tags_usage_path(conn, :create), usage: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Usage"
    end
  end

  describe "edit usage" do
    setup [:create_usage]

    test "renders form for editing chosen usage", %{conn: conn, usage: usage} do
      conn = get(conn, Routes.tags_usage_path(conn, :edit, usage))
      assert html_response(conn, 200) =~ "Edit Usage"
    end
  end

  describe "update usage" do
    setup [:create_usage]

    test "redirects when data is valid", %{conn: conn, usage: usage} do
      conn = put(conn, Routes.tags_usage_path(conn, :update, usage), usage: @update_attrs)
      assert redirected_to(conn) == Routes.tags_usage_path(conn, :show, usage)

      conn = get(conn, Routes.tags_usage_path(conn, :show, usage))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, usage: usage} do
      conn = put(conn, Routes.tags_usage_path(conn, :update, usage), usage: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Usage"
    end
  end

  describe "delete usage" do
    setup [:create_usage]

    test "deletes chosen usage", %{conn: conn, usage: usage} do
      conn = delete(conn, Routes.tags_usage_path(conn, :delete, usage))
      assert redirected_to(conn) == Routes.tags_usage_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.tags_usage_path(conn, :show, usage))
      end
    end
  end

  defp create_usage(_) do
    usage = fixture(:usage)
    {:ok, usage: usage}
  end
end
