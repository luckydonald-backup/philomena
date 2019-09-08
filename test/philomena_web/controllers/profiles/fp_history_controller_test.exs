defmodule PhilomenaWeb.Profiles.FpHistoryControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Profiles

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:fp_history) do
    {:ok, fp_history} = Profiles.create_fp_history(@create_attrs)
    fp_history
  end

  describe "index" do
    test "lists all fp_histories", %{conn: conn} do
      conn = get(conn, Routes.profiles_fp_history_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Fp histories"
    end
  end

  describe "new fp_history" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.profiles_fp_history_path(conn, :new))
      assert html_response(conn, 200) =~ "New Fp history"
    end
  end

  describe "create fp_history" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.profiles_fp_history_path(conn, :create), fp_history: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.profiles_fp_history_path(conn, :show, id)

      conn = get(conn, Routes.profiles_fp_history_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Fp history"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.profiles_fp_history_path(conn, :create), fp_history: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Fp history"
    end
  end

  describe "edit fp_history" do
    setup [:create_fp_history]

    test "renders form for editing chosen fp_history", %{conn: conn, fp_history: fp_history} do
      conn = get(conn, Routes.profiles_fp_history_path(conn, :edit, fp_history))
      assert html_response(conn, 200) =~ "Edit Fp history"
    end
  end

  describe "update fp_history" do
    setup [:create_fp_history]

    test "redirects when data is valid", %{conn: conn, fp_history: fp_history} do
      conn = put(conn, Routes.profiles_fp_history_path(conn, :update, fp_history), fp_history: @update_attrs)
      assert redirected_to(conn) == Routes.profiles_fp_history_path(conn, :show, fp_history)

      conn = get(conn, Routes.profiles_fp_history_path(conn, :show, fp_history))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, fp_history: fp_history} do
      conn = put(conn, Routes.profiles_fp_history_path(conn, :update, fp_history), fp_history: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Fp history"
    end
  end

  describe "delete fp_history" do
    setup [:create_fp_history]

    test "deletes chosen fp_history", %{conn: conn, fp_history: fp_history} do
      conn = delete(conn, Routes.profiles_fp_history_path(conn, :delete, fp_history))
      assert redirected_to(conn) == Routes.profiles_fp_history_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.profiles_fp_history_path(conn, :show, fp_history))
      end
    end
  end

  defp create_fp_history(_) do
    fp_history = fixture(:fp_history)
    {:ok, fp_history: fp_history}
  end
end
