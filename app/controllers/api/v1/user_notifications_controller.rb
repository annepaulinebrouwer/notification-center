class Api::V1::UserNotificationsController < Api::V1::BaseController
  before_action :set_user_notifications, only: [:show]

  def show
  end

  private

  def set_user_notifications
    @user_notification = UserNotification.find(params[:id])
  end
end
