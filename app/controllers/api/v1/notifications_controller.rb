class Api::V1::NotificationsController < ApplicationController
  before_action :set_notification, only: [:show]
  acts_as_token_authentication_handler_for User, only: [:create]

  def show
  end

  def create
   return render json: { status: :unauthorized } unless current_user.admin?

    @notification = Notification.new(notification_params)
    if @notification.save
      render :show, status: :created
    else
      render_error
    end
  end

  private

  def notification_params
    params.require(:notification).permit(:date, :title, :description)
  end

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def render_error
    render json: { errors: @notification.errors.full_messages },
      status: :unprocessable_entity
  end
end
