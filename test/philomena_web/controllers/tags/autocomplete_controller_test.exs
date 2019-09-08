defmodule PhilomenaWeb.Tags.AutocompleteControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Tags

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:autocomplete) do
    {:ok, autocomplete} = Tags.create_autocomplete(@create_attrs)
    autocomplete
  end

  describe "index" do
    test "lists all autocomplete", %{conn: conn} do
      conn = get(conn, Routes.tags_autocomplete_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Autocomplete"
    end
  end

  describe "new autocomplete" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.tags_autocomplete_path(conn, :new))
      assert html_response(conn, 200) =~ "New Autocomplete"
    end
  end

  describe "create autocomplete" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.tags_autocomplete_path(conn, :create), autocomplete: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.tags_autocomplete_path(conn, :show, id)

      conn = get(conn, Routes.tags_autocomplete_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Autocomplete"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.tags_autocomplete_path(conn, :create), autocomplete: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Autocomplete"
    end
  end

  describe "edit autocomplete" do
    setup [:create_autocomplete]

    test "renders form for editing chosen autocomplete", %{conn: conn, autocomplete: autocomplete} do
      conn = get(conn, Routes.tags_autocomplete_path(conn, :edit, autocomplete))
      assert html_response(conn, 200) =~ "Edit Autocomplete"
    end
  end

  describe "update autocomplete" do
    setup [:create_autocomplete]

    test "redirects when data is valid", %{conn: conn, autocomplete: autocomplete} do
      conn = put(conn, Routes.tags_autocomplete_path(conn, :update, autocomplete), autocomplete: @update_attrs)
      assert redirected_to(conn) == Routes.tags_autocomplete_path(conn, :show, autocomplete)

      conn = get(conn, Routes.tags_autocomplete_path(conn, :show, autocomplete))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, autocomplete: autocomplete} do
      conn = put(conn, Routes.tags_autocomplete_path(conn, :update, autocomplete), autocomplete: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Autocomplete"
    end
  end

  describe "delete autocomplete" do
    setup [:create_autocomplete]

    test "deletes chosen autocomplete", %{conn: conn, autocomplete: autocomplete} do
      conn = delete(conn, Routes.tags_autocomplete_path(conn, :delete, autocomplete))
      assert redirected_to(conn) == Routes.tags_autocomplete_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.tags_autocomplete_path(conn, :show, autocomplete))
      end
    end
  end

  defp create_autocomplete(_) do
    autocomplete = fixture(:autocomplete)
    {:ok, autocomplete: autocomplete}
  end
end
