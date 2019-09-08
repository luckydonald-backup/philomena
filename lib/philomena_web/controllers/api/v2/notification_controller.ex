defmodule PhilomenaWeb.Api.V2.NotificationController do
  use PhilomenaWeb, :controller

  alias Philomena.Notifications
  alias Philomena.Notifications.Notification

  action_fallback PhilomenaWeb.FallbackController

  def index(conn, _params) do
    notifications = Notifications.list_notifications()
    render(conn, "index.json", notifications: notifications)
  end

  def create(conn, %{"notification" => notification_params}) do
    with {:ok, %Notification{} = notification} <- Notifications.create_notification(notification_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_v2_notification_path(conn, :show, notification))
      |> render("show.json", notification: notification)
    end
  end

  def show(conn, %{"id" => id}) do
    notification = Notifications.get_notification!(id)
    render(conn, "show.json", notification: notification)
  end

  def update(conn, %{"id" => id, "notification" => notification_params}) do
    notification = Notifications.get_notification!(id)

    with {:ok, %Notification{} = notification} <- Notifications.update_notification(notification, notification_params) do
      render(conn, "show.json", notification: notification)
    end
  end

  def delete(conn, %{"id" => id}) do
    notification = Notifications.get_notification!(id)

    with {:ok, %Notification{}} <- Notifications.delete_notification(notification) do
      send_resp(conn, :no_content, "")
    end
  end
end
