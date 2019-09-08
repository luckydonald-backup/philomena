defmodule PhilomenaWeb.CaptchaControllerTest do
  use PhilomenaWeb.ConnCase

  alias Philomena.Captchas

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:captcha) do
    {:ok, captcha} = Captchas.create_captcha(@create_attrs)
    captcha
  end

  describe "index" do
    test "lists all captchas", %{conn: conn} do
      conn = get(conn, Routes.captcha_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Captchas"
    end
  end

  describe "new captcha" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.captcha_path(conn, :new))
      assert html_response(conn, 200) =~ "New Captcha"
    end
  end

  describe "create captcha" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.captcha_path(conn, :create), captcha: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.captcha_path(conn, :show, id)

      conn = get(conn, Routes.captcha_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Captcha"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.captcha_path(conn, :create), captcha: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Captcha"
    end
  end

  describe "edit captcha" do
    setup [:create_captcha]

    test "renders form for editing chosen captcha", %{conn: conn, captcha: captcha} do
      conn = get(conn, Routes.captcha_path(conn, :edit, captcha))
      assert html_response(conn, 200) =~ "Edit Captcha"
    end
  end

  describe "update captcha" do
    setup [:create_captcha]

    test "redirects when data is valid", %{conn: conn, captcha: captcha} do
      conn = put(conn, Routes.captcha_path(conn, :update, captcha), captcha: @update_attrs)
      assert redirected_to(conn) == Routes.captcha_path(conn, :show, captcha)

      conn = get(conn, Routes.captcha_path(conn, :show, captcha))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, captcha: captcha} do
      conn = put(conn, Routes.captcha_path(conn, :update, captcha), captcha: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Captcha"
    end
  end

  describe "delete captcha" do
    setup [:create_captcha]

    test "deletes chosen captcha", %{conn: conn, captcha: captcha} do
      conn = delete(conn, Routes.captcha_path(conn, :delete, captcha))
      assert redirected_to(conn) == Routes.captcha_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.captcha_path(conn, :show, captcha))
      end
    end
  end

  defp create_captcha(_) do
    captcha = fixture(:captcha)
    {:ok, captcha: captcha}
  end
end
