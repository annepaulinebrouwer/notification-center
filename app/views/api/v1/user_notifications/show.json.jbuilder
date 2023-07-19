json.extract! @user_notification, :id, :seen
json.user do
  json.id @user_notification.user.id
end
json.notification do
  json.id @user_notification.notification.id
  json.title @user_notification.notification.title
  json.description @user_notification.notification.description
end
