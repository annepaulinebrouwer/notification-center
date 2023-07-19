class Api::V1::UserNotificationsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, only: [:index, :create]
  before_action :set_user_notifications, only: [:show]
  before_action :set_notification, only: [:create]
  before_action :set_user, only: [:create]

  def index
    # @user_notifications = current_user.user_notifications.not_seen
    @user_notifications = current_user.user_notifications
    @user_notifications.update_all(seen: true)
  end

  def show
  end

  def create
    return render json: { status: :unauthorized } unless current_user.admin?

    @user_notification = @user.user_notifications.build(notification_id: @notification.id)
    ## 10% change it will raise a StandardError
    MockPushService.send(
      title: @notification.title,
      description: @notification.description,
      token: current_user.authentication_token
    ) if Rails.env.development?

    if @user_notification.save
      render :show
    else
      render_error
    end
  rescue StandardError => e
    Rails.logger.error "Error when creating UserNotification with notification_id: #{@notification&.id} and user_id: #{@user&.id}"
    Rails.logger.error(e.message)
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def set_user_notifications
    @user_notification = UserNotification.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_notification
    @notification = Notification.find(params[:notification_id])
  end

  def render_error
    render json: { errors: @user_notifications.errors.full_messages },
           status: :unprocessable_entity
  end
end
