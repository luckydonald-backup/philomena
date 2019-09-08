defmodule PhilomenaWeb.CaptchaController do
  use PhilomenaWeb, :controller

  alias Philomena.Captchas
  alias Philomena.Captchas.Captcha

  def index(conn, _params) do
    captchas = Captchas.list_captchas()
    render(conn, "index.html", captchas: captchas)
  end

  def new(conn, _params) do
    changeset = Captchas.change_captcha(%Captcha{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"captcha" => captcha_params}) do
    case Captchas.create_captcha(captcha_params) do
      {:ok, captcha} ->
        conn
        |> put_flash(:info, "Captcha created successfully.")
        |> redirect(to: Routes.captcha_path(conn, :show, captcha))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    captcha = Captchas.get_captcha!(id)
    render(conn, "show.html", captcha: captcha)
  end

  def edit(conn, %{"id" => id}) do
    captcha = Captchas.get_captcha!(id)
    changeset = Captchas.change_captcha(captcha)
    render(conn, "edit.html", captcha: captcha, changeset: changeset)
  end

  def update(conn, %{"id" => id, "captcha" => captcha_params}) do
    captcha = Captchas.get_captcha!(id)

    case Captchas.update_captcha(captcha, captcha_params) do
      {:ok, captcha} ->
        conn
        |> put_flash(:info, "Captcha updated successfully.")
        |> redirect(to: Routes.captcha_path(conn, :show, captcha))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", captcha: captcha, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    captcha = Captchas.get_captcha!(id)
    {:ok, _captcha} = Captchas.delete_captcha(captcha)

    conn
    |> put_flash(:info, "Captcha deleted successfully.")
    |> redirect(to: Routes.captcha_path(conn, :index))
  end
end
