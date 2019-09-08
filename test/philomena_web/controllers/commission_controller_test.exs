defmodule PhilomenaWeb.CommissionControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Commissions

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:commission) do
    {:ok, commission} = Commissions.create_commission(@create_attrs)
    commission
  end

  describe "index" do
    test "lists all commissions", %{conn: conn} do
      conn = get(conn, Routes.commission_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Commissions"
    end
  end

  describe "new commission" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.commission_path(conn, :new))
      assert html_response(conn, 200) =~ "New Commission"
    end
  end

  describe "create commission" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.commission_path(conn, :create), commission: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.commission_path(conn, :show, id)

      conn = get(conn, Routes.commission_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Commission"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.commission_path(conn, :create), commission: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Commission"
    end
  end

  describe "edit commission" do
    setup [:create_commission]

    test "renders form for editing chosen commission", %{conn: conn, commission: commission} do
      conn = get(conn, Routes.commission_path(conn, :edit, commission))
      assert html_response(conn, 200) =~ "Edit Commission"
    end
  end

  describe "update commission" do
    setup [:create_commission]

    test "redirects when data is valid", %{conn: conn, commission: commission} do
      conn = put(conn, Routes.commission_path(conn, :update, commission), commission: @update_attrs)
      assert redirected_to(conn) == Routes.commission_path(conn, :show, commission)

      conn = get(conn, Routes.commission_path(conn, :show, commission))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, commission: commission} do
      conn = put(conn, Routes.commission_path(conn, :update, commission), commission: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Commission"
    end
  end

  describe "delete commission" do
    setup [:create_commission]

    test "deletes chosen commission", %{conn: conn, commission: commission} do
      conn = delete(conn, Routes.commission_path(conn, :delete, commission))
      assert redirected_to(conn) == Routes.commission_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.commission_path(conn, :show, commission))
      end
    end
  end

  defp create_commission(_) do
    commission = fixture(:commission)
    {:ok, commission: commission}
  end
end
