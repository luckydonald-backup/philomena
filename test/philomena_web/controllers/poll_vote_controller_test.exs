defmodule PhilomenaWeb.PollVoteControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.PollVotes

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:poll_vote) do
    {:ok, poll_vote} = PollVotes.create_poll_vote(@create_attrs)
    poll_vote
  end

  describe "index" do
    test "lists all poll_votes", %{conn: conn} do
      conn = get(conn, Routes.poll_vote_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Poll votes"
    end
  end

  describe "new poll_vote" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.poll_vote_path(conn, :new))
      assert html_response(conn, 200) =~ "New Poll vote"
    end
  end

  describe "create poll_vote" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.poll_vote_path(conn, :create), poll_vote: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.poll_vote_path(conn, :show, id)

      conn = get(conn, Routes.poll_vote_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Poll vote"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.poll_vote_path(conn, :create), poll_vote: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Poll vote"
    end
  end

  describe "edit poll_vote" do
    setup [:create_poll_vote]

    test "renders form for editing chosen poll_vote", %{conn: conn, poll_vote: poll_vote} do
      conn = get(conn, Routes.poll_vote_path(conn, :edit, poll_vote))
      assert html_response(conn, 200) =~ "Edit Poll vote"
    end
  end

  describe "update poll_vote" do
    setup [:create_poll_vote]

    test "redirects when data is valid", %{conn: conn, poll_vote: poll_vote} do
      conn = put(conn, Routes.poll_vote_path(conn, :update, poll_vote), poll_vote: @update_attrs)
      assert redirected_to(conn) == Routes.poll_vote_path(conn, :show, poll_vote)

      conn = get(conn, Routes.poll_vote_path(conn, :show, poll_vote))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, poll_vote: poll_vote} do
      conn = put(conn, Routes.poll_vote_path(conn, :update, poll_vote), poll_vote: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Poll vote"
    end
  end

  describe "delete poll_vote" do
    setup [:create_poll_vote]

    test "deletes chosen poll_vote", %{conn: conn, poll_vote: poll_vote} do
      conn = delete(conn, Routes.poll_vote_path(conn, :delete, poll_vote))
      assert redirected_to(conn) == Routes.poll_vote_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.poll_vote_path(conn, :show, poll_vote))
      end
    end
  end

  defp create_poll_vote(_) do
    poll_vote = fixture(:poll_vote)
    {:ok, poll_vote: poll_vote}
  end
end
