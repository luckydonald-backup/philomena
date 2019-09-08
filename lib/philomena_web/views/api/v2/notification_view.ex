defmodule PhilomenaWeb.Api.V2.NotificationView do
  use PhilomenaWeb, :view
  alias PhilomenaWeb.Api.V2.NotificationView

  def render("index.json", %{notifications: notifications}) do
    %{data: render_many(notifications, NotificationView, "notification.json")}
  end

  def render("show.json", %{notification: notification}) do
    %{data: render_one(notification, NotificationView, "notification.json")}
  end

  def render("notification.json", %{notification: notification}) do
    %{id: notification.id}
  end
end
