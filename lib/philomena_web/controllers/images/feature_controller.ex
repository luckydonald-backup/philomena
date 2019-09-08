defmodule PhilomenaWeb.Images.FeatureController do
  use PhilomenaWeb, :controller

  alias Philomena.Images
  alias Philomena.Images.Feature

  def index(conn, _params) do
    image_features = Images.list_image_features()
    render(conn, "index.html", image_features: image_features)
  end

  def new(conn, _params) do
    changeset = Images.change_feature(%Feature{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"feature" => feature_params}) do
    case Images.create_feature(feature_params) do
      {:ok, feature} ->
        conn
        |> put_flash(:info, "Feature created successfully.")
        |> redirect(to: Routes.images_feature_path(conn, :show, feature))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    feature = Images.get_feature!(id)
    render(conn, "show.html", feature: feature)
  end

  def edit(conn, %{"id" => id}) do
    feature = Images.get_feature!(id)
    changeset = Images.change_feature(feature)
    render(conn, "edit.html", feature: feature, changeset: changeset)
  end

  def update(conn, %{"id" => id, "feature" => feature_params}) do
    feature = Images.get_feature!(id)

    case Images.update_feature(feature, feature_params) do
      {:ok, feature} ->
        conn
        |> put_flash(:info, "Feature updated successfully.")
        |> redirect(to: Routes.images_feature_path(conn, :show, feature))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", feature: feature, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    feature = Images.get_feature!(id)
    {:ok, _feature} = Images.delete_feature(feature)

    conn
    |> put_flash(:info, "Feature deleted successfully.")
    |> redirect(to: Routes.images_feature_path(conn, :index))
  end
end
