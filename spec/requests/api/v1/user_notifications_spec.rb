require 'swagger_helper'

RSpec.describe 'api/v1/user_notifications', type: :request do
  path '/api/v1/user_notifications/{id}' do
    get 'Get a user_notification' do
      tags 'UserNotifications'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '404', 'UserNotification not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
