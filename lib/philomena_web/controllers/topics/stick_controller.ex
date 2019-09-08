defmodule PhilomenaWeb.Topics.StickController do
  use PhilomenaWeb, :controller

  alias Philomena.Topics
  alias Philomena.Topics.Stick

  def index(conn, _params) do
    sticks = Topics.list_sticks()
    render(conn, "index.html", sticks: sticks)
  end

  def new(conn, _params) do
    changeset = Topics.change_stick(%Stick{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"stick" => stick_params}) do
    case Topics.create_stick(stick_params) do
      {:ok, stick} ->
        conn
        |> put_flash(:info, "Stick created successfully.")
        |> redirect(to: Routes.topics_stick_path(conn, :show, stick))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    stick = Topics.get_stick!(id)
    render(conn, "show.html", stick: stick)
  end

  def edit(conn, %{"id" => id}) do
    stick = Topics.get_stick!(id)
    changeset = Topics.change_stick(stick)
    render(conn, "edit.html", stick: stick, changeset: changeset)
  end

  def update(conn, %{"id" => id, "stick" => stick_params}) do
    stick = Topics.get_stick!(id)

    case Topics.update_stick(stick, stick_params) do
      {:ok, stick} ->
        conn
        |> put_flash(:info, "Stick updated successfully.")
        |> redirect(to: Routes.topics_stick_path(conn, :show, stick))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", stick: stick, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    stick = Topics.get_stick!(id)
    {:ok, _stick} = Topics.delete_stick(stick)

    conn
    |> put_flash(:info, "Stick deleted successfully.")
    |> redirect(to: Routes.topics_stick_path(conn, :index))
  end
end
