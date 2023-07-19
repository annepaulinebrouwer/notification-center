class Api::V1::NotificationsController < ApplicationController
  before_action :set_notification, only: [:show]

  def show
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
