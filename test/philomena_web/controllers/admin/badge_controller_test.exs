defmodule PhilomenaWeb.Admin.BadgeControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Badges

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:badge) do
    {:ok, badge} = Badges.create_badge(@create_attrs)
    badge
  end

  describe "index" do
    test "lists all badges", %{conn: conn} do
      conn = get(conn, Routes.admin_badge_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Badges"
    end
  end

  describe "new badge" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.admin_badge_path(conn, :new))
      assert html_response(conn, 200) =~ "New Badge"
    end
  end

  describe "create badge" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.admin_badge_path(conn, :create), badge: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_badge_path(conn, :show, id)

      conn = get(conn, Routes.admin_badge_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Badge"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admin_badge_path(conn, :create), badge: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Badge"
    end
  end

  describe "edit badge" do
    setup [:create_badge]

    test "renders form for editing chosen badge", %{conn: conn, badge: badge} do
      conn = get(conn, Routes.admin_badge_path(conn, :edit, badge))
      assert html_response(conn, 200) =~ "Edit Badge"
    end
  end

  describe "update badge" do
    setup [:create_badge]

    test "redirects when data is valid", %{conn: conn, badge: badge} do
      conn = put(conn, Routes.admin_badge_path(conn, :update, badge), badge: @update_attrs)
      assert redirected_to(conn) == Routes.admin_badge_path(conn, :show, badge)

      conn = get(conn, Routes.admin_badge_path(conn, :show, badge))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, badge: badge} do
      conn = put(conn, Routes.admin_badge_path(conn, :update, badge), badge: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Badge"
    end
  end

  describe "delete badge" do
    setup [:create_badge]

    test "deletes chosen badge", %{conn: conn, badge: badge} do
      conn = delete(conn, Routes.admin_badge_path(conn, :delete, badge))
      assert redirected_to(conn) == Routes.admin_badge_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.admin_badge_path(conn, :show, badge))
      end
    end
  end

  defp create_badge(_) do
    badge = fixture(:badge)
    {:ok, badge: badge}
  end
end
