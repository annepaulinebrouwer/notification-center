json.array! @user_notifications do |user_notification|
  json.notification do
    json.id user_notification.notification.id
    json.title user_notification.notification.title
    json.description user_notification.notification.description
  end
end
