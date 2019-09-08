defmodule PhilomenaWeb.Profiles.BadgeAwardControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Profiles

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:badge_award) do
    {:ok, badge_award} = Profiles.create_badge_award(@create_attrs)
    badge_award
  end

  describe "index" do
    test "lists all badge_awards", %{conn: conn} do
      conn = get(conn, Routes.profiles_badge_award_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Badge awards"
    end
  end

  describe "new badge_award" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.profiles_badge_award_path(conn, :new))
      assert html_response(conn, 200) =~ "New Badge award"
    end
  end

  describe "create badge_award" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.profiles_badge_award_path(conn, :create), badge_award: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.profiles_badge_award_path(conn, :show, id)

      conn = get(conn, Routes.profiles_badge_award_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Badge award"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.profiles_badge_award_path(conn, :create), badge_award: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Badge award"
    end
  end

  describe "edit badge_award" do
    setup [:create_badge_award]

    test "renders form for editing chosen badge_award", %{conn: conn, badge_award: badge_award} do
      conn = get(conn, Routes.profiles_badge_award_path(conn, :edit, badge_award))
      assert html_response(conn, 200) =~ "Edit Badge award"
    end
  end

  describe "update badge_award" do
    setup [:create_badge_award]

    test "redirects when data is valid", %{conn: conn, badge_award: badge_award} do
      conn = put(conn, Routes.profiles_badge_award_path(conn, :update, badge_award), badge_award: @update_attrs)
      assert redirected_to(conn) == Routes.profiles_badge_award_path(conn, :show, badge_award)

      conn = get(conn, Routes.profiles_badge_award_path(conn, :show, badge_award))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, badge_award: badge_award} do
      conn = put(conn, Routes.profiles_badge_award_path(conn, :update, badge_award), badge_award: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Badge award"
    end
  end

  describe "delete badge_award" do
    setup [:create_badge_award]

    test "deletes chosen badge_award", %{conn: conn, badge_award: badge_award} do
      conn = delete(conn, Routes.profiles_badge_award_path(conn, :delete, badge_award))
      assert redirected_to(conn) == Routes.profiles_badge_award_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.profiles_badge_award_path(conn, :show, badge_award))
      end
    end
  end

  defp create_badge_award(_) do
    badge_award = fixture(:badge_award)
    {:ok, badge_award: badge_award}
  end
end
