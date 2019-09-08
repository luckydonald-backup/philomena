defmodule PhilomenaWeb.Profiles.ScratchpadControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Profiles

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:scratchpad) do
    {:ok, scratchpad} = Profiles.create_scratchpad(@create_attrs)
    scratchpad
  end

  describe "index" do
    test "lists all scratchpads", %{conn: conn} do
      conn = get(conn, Routes.profiles_scratchpad_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Scratchpads"
    end
  end

  describe "new scratchpad" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.profiles_scratchpad_path(conn, :new))
      assert html_response(conn, 200) =~ "New Scratchpad"
    end
  end

  describe "create scratchpad" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.profiles_scratchpad_path(conn, :create), scratchpad: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.profiles_scratchpad_path(conn, :show, id)

      conn = get(conn, Routes.profiles_scratchpad_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Scratchpad"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.profiles_scratchpad_path(conn, :create), scratchpad: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Scratchpad"
    end
  end

  describe "edit scratchpad" do
    setup [:create_scratchpad]

    test "renders form for editing chosen scratchpad", %{conn: conn, scratchpad: scratchpad} do
      conn = get(conn, Routes.profiles_scratchpad_path(conn, :edit, scratchpad))
      assert html_response(conn, 200) =~ "Edit Scratchpad"
    end
  end

  describe "update scratchpad" do
    setup [:create_scratchpad]

    test "redirects when data is valid", %{conn: conn, scratchpad: scratchpad} do
      conn = put(conn, Routes.profiles_scratchpad_path(conn, :update, scratchpad), scratchpad: @update_attrs)
      assert redirected_to(conn) == Routes.profiles_scratchpad_path(conn, :show, scratchpad)

      conn = get(conn, Routes.profiles_scratchpad_path(conn, :show, scratchpad))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, scratchpad: scratchpad} do
      conn = put(conn, Routes.profiles_scratchpad_path(conn, :update, scratchpad), scratchpad: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Scratchpad"
    end
  end

  describe "delete scratchpad" do
    setup [:create_scratchpad]

    test "deletes chosen scratchpad", %{conn: conn, scratchpad: scratchpad} do
      conn = delete(conn, Routes.profiles_scratchpad_path(conn, :delete, scratchpad))
      assert redirected_to(conn) == Routes.profiles_scratchpad_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.profiles_scratchpad_path(conn, :show, scratchpad))
      end
    end
  end

  defp create_scratchpad(_) do
    scratchpad = fixture(:scratchpad)
    {:ok, scratchpad: scratchpad}
  end
end
