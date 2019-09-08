defmodule PhilomenaWeb.Images.HashControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Images

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:hash) do
    {:ok, hash} = Images.create_hash(@create_attrs)
    hash
  end

  describe "index" do
    test "lists all image_hashes", %{conn: conn} do
      conn = get(conn, Routes.images_hash_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Image hashes"
    end
  end

  describe "new hash" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.images_hash_path(conn, :new))
      assert html_response(conn, 200) =~ "New Hash"
    end
  end

  describe "create hash" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.images_hash_path(conn, :create), hash: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.images_hash_path(conn, :show, id)

      conn = get(conn, Routes.images_hash_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Hash"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.images_hash_path(conn, :create), hash: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Hash"
    end
  end

  describe "edit hash" do
    setup [:create_hash]

    test "renders form for editing chosen hash", %{conn: conn, hash: hash} do
      conn = get(conn, Routes.images_hash_path(conn, :edit, hash))
      assert html_response(conn, 200) =~ "Edit Hash"
    end
  end

  describe "update hash" do
    setup [:create_hash]

    test "redirects when data is valid", %{conn: conn, hash: hash} do
      conn = put(conn, Routes.images_hash_path(conn, :update, hash), hash: @update_attrs)
      assert redirected_to(conn) == Routes.images_hash_path(conn, :show, hash)

      conn = get(conn, Routes.images_hash_path(conn, :show, hash))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, hash: hash} do
      conn = put(conn, Routes.images_hash_path(conn, :update, hash), hash: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Hash"
    end
  end

  describe "delete hash" do
    setup [:create_hash]

    test "deletes chosen hash", %{conn: conn, hash: hash} do
      conn = delete(conn, Routes.images_hash_path(conn, :delete, hash))
      assert redirected_to(conn) == Routes.images_hash_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.images_hash_path(conn, :show, hash))
      end
    end
  end

  defp create_hash(_) do
    hash = fixture(:hash)
    {:ok, hash: hash}
  end
end
