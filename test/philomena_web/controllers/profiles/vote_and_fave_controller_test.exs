defmodule PhilomenaWeb.Profiles.VoteAndFaveControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Profiles

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:vote_and_fave) do
    {:ok, vote_and_fave} = Profiles.create_vote_and_fave(@create_attrs)
    vote_and_fave
  end

  describe "index" do
    test "lists all votes_and_faves", %{conn: conn} do
      conn = get(conn, Routes.profiles_vote_and_fave_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Votes and faves"
    end
  end

  describe "new vote_and_fave" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.profiles_vote_and_fave_path(conn, :new))
      assert html_response(conn, 200) =~ "New Vote and fave"
    end
  end

  describe "create vote_and_fave" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.profiles_vote_and_fave_path(conn, :create), vote_and_fave: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.profiles_vote_and_fave_path(conn, :show, id)

      conn = get(conn, Routes.profiles_vote_and_fave_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Vote and fave"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.profiles_vote_and_fave_path(conn, :create), vote_and_fave: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Vote and fave"
    end
  end

  describe "edit vote_and_fave" do
    setup [:create_vote_and_fave]

    test "renders form for editing chosen vote_and_fave", %{conn: conn, vote_and_fave: vote_and_fave} do
      conn = get(conn, Routes.profiles_vote_and_fave_path(conn, :edit, vote_and_fave))
      assert html_response(conn, 200) =~ "Edit Vote and fave"
    end
  end

  describe "update vote_and_fave" do
    setup [:create_vote_and_fave]

    test "redirects when data is valid", %{conn: conn, vote_and_fave: vote_and_fave} do
      conn = put(conn, Routes.profiles_vote_and_fave_path(conn, :update, vote_and_fave), vote_and_fave: @update_attrs)
      assert redirected_to(conn) == Routes.profiles_vote_and_fave_path(conn, :show, vote_and_fave)

      conn = get(conn, Routes.profiles_vote_and_fave_path(conn, :show, vote_and_fave))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, vote_and_fave: vote_and_fave} do
      conn = put(conn, Routes.profiles_vote_and_fave_path(conn, :update, vote_and_fave), vote_and_fave: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Vote and fave"
    end
  end

  describe "delete vote_and_fave" do
    setup [:create_vote_and_fave]

    test "deletes chosen vote_and_fave", %{conn: conn, vote_and_fave: vote_and_fave} do
      conn = delete(conn, Routes.profiles_vote_and_fave_path(conn, :delete, vote_and_fave))
      assert redirected_to(conn) == Routes.profiles_vote_and_fave_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.profiles_vote_and_fave_path(conn, :show, vote_and_fave))
      end
    end
  end

  defp create_vote_and_fave(_) do
    vote_and_fave = fixture(:vote_and_fave)
    {:ok, vote_and_fave: vote_and_fave}
  end
end
