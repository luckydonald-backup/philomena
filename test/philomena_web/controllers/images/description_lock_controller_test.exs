defmodule PhilomenaWeb.Images.DescriptionLockControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Images

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:description_lock) do
    {:ok, description_lock} = Images.create_description_lock(@create_attrs)
    description_lock
  end

  describe "index" do
    test "lists all description_locks", %{conn: conn} do
      conn = get(conn, Routes.images_description_lock_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Description locks"
    end
  end

  describe "new description_lock" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.images_description_lock_path(conn, :new))
      assert html_response(conn, 200) =~ "New Description lock"
    end
  end

  describe "create description_lock" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.images_description_lock_path(conn, :create), description_lock: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.images_description_lock_path(conn, :show, id)

      conn = get(conn, Routes.images_description_lock_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Description lock"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.images_description_lock_path(conn, :create), description_lock: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Description lock"
    end
  end

  describe "edit description_lock" do
    setup [:create_description_lock]

    test "renders form for editing chosen description_lock", %{conn: conn, description_lock: description_lock} do
      conn = get(conn, Routes.images_description_lock_path(conn, :edit, description_lock))
      assert html_response(conn, 200) =~ "Edit Description lock"
    end
  end

  describe "update description_lock" do
    setup [:create_description_lock]

    test "redirects when data is valid", %{conn: conn, description_lock: description_lock} do
      conn = put(conn, Routes.images_description_lock_path(conn, :update, description_lock), description_lock: @update_attrs)
      assert redirected_to(conn) == Routes.images_description_lock_path(conn, :show, description_lock)

      conn = get(conn, Routes.images_description_lock_path(conn, :show, description_lock))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, description_lock: description_lock} do
      conn = put(conn, Routes.images_description_lock_path(conn, :update, description_lock), description_lock: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Description lock"
    end
  end

  describe "delete description_lock" do
    setup [:create_description_lock]

    test "deletes chosen description_lock", %{conn: conn, description_lock: description_lock} do
      conn = delete(conn, Routes.images_description_lock_path(conn, :delete, description_lock))
      assert redirected_to(conn) == Routes.images_description_lock_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.images_description_lock_path(conn, :show, description_lock))
      end
    end
  end

  defp create_description_lock(_) do
    description_lock = fixture(:description_lock)
    {:ok, description_lock: description_lock}
  end
end
