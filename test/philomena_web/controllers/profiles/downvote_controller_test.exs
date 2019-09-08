defmodule PhilomenaWeb.Profiles.DownvoteControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Profiles

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:downvote) do
    {:ok, downvote} = Profiles.create_downvote(@create_attrs)
    downvote
  end

  describe "index" do
    test "lists all downvotes", %{conn: conn} do
      conn = get(conn, Routes.profiles_downvote_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Downvotes"
    end
  end

  describe "new downvote" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.profiles_downvote_path(conn, :new))
      assert html_response(conn, 200) =~ "New Downvote"
    end
  end

  describe "create downvote" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.profiles_downvote_path(conn, :create), downvote: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.profiles_downvote_path(conn, :show, id)

      conn = get(conn, Routes.profiles_downvote_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Downvote"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.profiles_downvote_path(conn, :create), downvote: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Downvote"
    end
  end

  describe "edit downvote" do
    setup [:create_downvote]

    test "renders form for editing chosen downvote", %{conn: conn, downvote: downvote} do
      conn = get(conn, Routes.profiles_downvote_path(conn, :edit, downvote))
      assert html_response(conn, 200) =~ "Edit Downvote"
    end
  end

  describe "update downvote" do
    setup [:create_downvote]

    test "redirects when data is valid", %{conn: conn, downvote: downvote} do
      conn = put(conn, Routes.profiles_downvote_path(conn, :update, downvote), downvote: @update_attrs)
      assert redirected_to(conn) == Routes.profiles_downvote_path(conn, :show, downvote)

      conn = get(conn, Routes.profiles_downvote_path(conn, :show, downvote))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, downvote: downvote} do
      conn = put(conn, Routes.profiles_downvote_path(conn, :update, downvote), downvote: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Downvote"
    end
  end

  describe "delete downvote" do
    setup [:create_downvote]

    test "deletes chosen downvote", %{conn: conn, downvote: downvote} do
      conn = delete(conn, Routes.profiles_downvote_path(conn, :delete, downvote))
      assert redirected_to(conn) == Routes.profiles_downvote_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.profiles_downvote_path(conn, :show, downvote))
      end
    end
  end

  defp create_downvote(_) do
    downvote = fixture(:downvote)
    {:ok, downvote: downvote}
  end
end
