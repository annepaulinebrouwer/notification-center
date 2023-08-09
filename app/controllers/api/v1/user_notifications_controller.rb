class Api::V1::UserNotificationsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, only: %i[index create update]
  before_action :set_user_notifications, only: %i[show update]
  before_action :set_notification, only: [:create]

  def index
    @user_notifications = current_user.user_notifications.not_seen
  end

  def show
  end

  def create
    return render json: { status: :unauthorized } unless current_user.admin?

    errors = []
    params[:user_ids].each do |user_id|
      user = User.find(user_id)
      @user_notification = user.user_notifications.build(notification_id: @notification.id)
      mock_push_service(current_user) if Rails.env.development?
      @user_notification.save
    rescue ActiveRecord::RecordNotFound => e
      errors << e
      next
    end
    errors.empty? ? :ok : users_not_found(errors)
  rescue StandardError => e
    render_standard_error(e)
  end

  def update
    return unless params[:seen] == 'true'

    @user_notification.update(seen: true)
  end

  private

  def set_user_notifications
    @user_notification = UserNotification.find(params[:id])
  end

  def set_notification
    @notification = Notification.find(params[:notification_id])
  end

  def users_not_found(errors)
    render json: { errors: },
           status: :not_found
  end

  def render_standard_error(e)
    Rails.logger.error "Error when creating UserNotification with notification_id: #{@notification&.id} and user_id: #{@user&.id}"
    Rails.logger.error(e.message)
    render json: { error: e.message }, status: :internal_server_error
  end

  def mock_push_service(current_user)
    ## 10% change it will raise a StandardError
    MockPushService.send(
      title: @notification.title,
      description: @notification.description,
      token: current_user.authentication_token
    )
  end
end
