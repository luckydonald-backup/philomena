defmodule PhilomenaWeb.SpoilerTypeControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.SpoilerTypes

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:spoiler_type) do
    {:ok, spoiler_type} = SpoilerTypes.create_spoiler_type(@create_attrs)
    spoiler_type
  end

  describe "index" do
    test "lists all spoiler_types", %{conn: conn} do
      conn = get(conn, Routes.spoiler_type_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Spoiler types"
    end
  end

  describe "new spoiler_type" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.spoiler_type_path(conn, :new))
      assert html_response(conn, 200) =~ "New Spoiler type"
    end
  end

  describe "create spoiler_type" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.spoiler_type_path(conn, :create), spoiler_type: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.spoiler_type_path(conn, :show, id)

      conn = get(conn, Routes.spoiler_type_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Spoiler type"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.spoiler_type_path(conn, :create), spoiler_type: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Spoiler type"
    end
  end

  describe "edit spoiler_type" do
    setup [:create_spoiler_type]

    test "renders form for editing chosen spoiler_type", %{conn: conn, spoiler_type: spoiler_type} do
      conn = get(conn, Routes.spoiler_type_path(conn, :edit, spoiler_type))
      assert html_response(conn, 200) =~ "Edit Spoiler type"
    end
  end

  describe "update spoiler_type" do
    setup [:create_spoiler_type]

    test "redirects when data is valid", %{conn: conn, spoiler_type: spoiler_type} do
      conn = put(conn, Routes.spoiler_type_path(conn, :update, spoiler_type), spoiler_type: @update_attrs)
      assert redirected_to(conn) == Routes.spoiler_type_path(conn, :show, spoiler_type)

      conn = get(conn, Routes.spoiler_type_path(conn, :show, spoiler_type))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, spoiler_type: spoiler_type} do
      conn = put(conn, Routes.spoiler_type_path(conn, :update, spoiler_type), spoiler_type: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Spoiler type"
    end
  end

  describe "delete spoiler_type" do
    setup [:create_spoiler_type]

    test "deletes chosen spoiler_type", %{conn: conn, spoiler_type: spoiler_type} do
      conn = delete(conn, Routes.spoiler_type_path(conn, :delete, spoiler_type))
      assert redirected_to(conn) == Routes.spoiler_type_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.spoiler_type_path(conn, :show, spoiler_type))
      end
    end
  end

  defp create_spoiler_type(_) do
    spoiler_type = fixture(:spoiler_type)
    {:ok, spoiler_type: spoiler_type}
  end
end
