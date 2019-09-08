defmodule PhilomenaWeb.Galleries.RandomControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Galleries

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:random) do
    {:ok, random} = Galleries.create_random(@create_attrs)
    random
  end

  describe "index" do
    test "lists all random", %{conn: conn} do
      conn = get(conn, Routes.galleries_random_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Random"
    end
  end

  describe "new random" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.galleries_random_path(conn, :new))
      assert html_response(conn, 200) =~ "New Random"
    end
  end

  describe "create random" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.galleries_random_path(conn, :create), random: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.galleries_random_path(conn, :show, id)

      conn = get(conn, Routes.galleries_random_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Random"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.galleries_random_path(conn, :create), random: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Random"
    end
  end

  describe "edit random" do
    setup [:create_random]

    test "renders form for editing chosen random", %{conn: conn, random: random} do
      conn = get(conn, Routes.galleries_random_path(conn, :edit, random))
      assert html_response(conn, 200) =~ "Edit Random"
    end
  end

  describe "update random" do
    setup [:create_random]

    test "redirects when data is valid", %{conn: conn, random: random} do
      conn = put(conn, Routes.galleries_random_path(conn, :update, random), random: @update_attrs)
      assert redirected_to(conn) == Routes.galleries_random_path(conn, :show, random)

      conn = get(conn, Routes.galleries_random_path(conn, :show, random))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, random: random} do
      conn = put(conn, Routes.galleries_random_path(conn, :update, random), random: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Random"
    end
  end

  describe "delete random" do
    setup [:create_random]

    test "deletes chosen random", %{conn: conn, random: random} do
      conn = delete(conn, Routes.galleries_random_path(conn, :delete, random))
      assert redirected_to(conn) == Routes.galleries_random_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.galleries_random_path(conn, :show, random))
      end
    end
  end

  defp create_random(_) do
    random = fixture(:random)
    {:ok, random: random}
  end
end
