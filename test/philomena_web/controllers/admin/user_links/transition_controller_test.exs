defmodule PhilomenaWeb.Admin.UserLinks.TransitionControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.UserLink

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:transition) do
    {:ok, transition} = UserLink.create_transition(@create_attrs)
    transition
  end

  describe "index" do
    test "lists all user_links", %{conn: conn} do
      conn = get(conn, Routes.admin_user_links_transition_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing User links"
    end
  end

  describe "new transition" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.admin_user_links_transition_path(conn, :new))
      assert html_response(conn, 200) =~ "New Transition"
    end
  end

  describe "create transition" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.admin_user_links_transition_path(conn, :create), transition: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_user_links_transition_path(conn, :show, id)

      conn = get(conn, Routes.admin_user_links_transition_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Transition"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.admin_user_links_transition_path(conn, :create), transition: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Transition"
    end
  end

  describe "edit transition" do
    setup [:create_transition]

    test "renders form for editing chosen transition", %{conn: conn, transition: transition} do
      conn = get(conn, Routes.admin_user_links_transition_path(conn, :edit, transition))
      assert html_response(conn, 200) =~ "Edit Transition"
    end
  end

  describe "update transition" do
    setup [:create_transition]

    test "redirects when data is valid", %{conn: conn, transition: transition} do
      conn = put(conn, Routes.admin_user_links_transition_path(conn, :update, transition), transition: @update_attrs)
      assert redirected_to(conn) == Routes.admin_user_links_transition_path(conn, :show, transition)

      conn = get(conn, Routes.admin_user_links_transition_path(conn, :show, transition))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, transition: transition} do
      conn = put(conn, Routes.admin_user_links_transition_path(conn, :update, transition), transition: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Transition"
    end
  end

  describe "delete transition" do
    setup [:create_transition]

    test "deletes chosen transition", %{conn: conn, transition: transition} do
      conn = delete(conn, Routes.admin_user_links_transition_path(conn, :delete, transition))
      assert redirected_to(conn) == Routes.admin_user_links_transition_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.admin_user_links_transition_path(conn, :show, transition))
      end
    end
  end

  defp create_transition(_) do
    transition = fixture(:transition)
    {:ok, transition: transition}
  end
end
