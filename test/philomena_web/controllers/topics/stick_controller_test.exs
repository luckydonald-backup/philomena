defmodule PhilomenaWeb.Topics.StickControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Topics

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:stick) do
    {:ok, stick} = Topics.create_stick(@create_attrs)
    stick
  end

  describe "index" do
    test "lists all sticks", %{conn: conn} do
      conn = get(conn, Routes.topics_stick_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Sticks"
    end
  end

  describe "new stick" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.topics_stick_path(conn, :new))
      assert html_response(conn, 200) =~ "New Stick"
    end
  end

  describe "create stick" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.topics_stick_path(conn, :create), stick: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.topics_stick_path(conn, :show, id)

      conn = get(conn, Routes.topics_stick_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Stick"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.topics_stick_path(conn, :create), stick: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Stick"
    end
  end

  describe "edit stick" do
    setup [:create_stick]

    test "renders form for editing chosen stick", %{conn: conn, stick: stick} do
      conn = get(conn, Routes.topics_stick_path(conn, :edit, stick))
      assert html_response(conn, 200) =~ "Edit Stick"
    end
  end

  describe "update stick" do
    setup [:create_stick]

    test "redirects when data is valid", %{conn: conn, stick: stick} do
      conn = put(conn, Routes.topics_stick_path(conn, :update, stick), stick: @update_attrs)
      assert redirected_to(conn) == Routes.topics_stick_path(conn, :show, stick)

      conn = get(conn, Routes.topics_stick_path(conn, :show, stick))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, stick: stick} do
      conn = put(conn, Routes.topics_stick_path(conn, :update, stick), stick: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Stick"
    end
  end

  describe "delete stick" do
    setup [:create_stick]

    test "deletes chosen stick", %{conn: conn, stick: stick} do
      conn = delete(conn, Routes.topics_stick_path(conn, :delete, stick))
      assert redirected_to(conn) == Routes.topics_stick_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.topics_stick_path(conn, :show, stick))
      end
    end
  end

  defp create_stick(_) do
    stick = fixture(:stick)
    {:ok, stick: stick}
  end
end
