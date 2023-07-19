require 'swagger_helper'

RSpec.describe 'notifications', type: :request do
  describe 'Notification API' do
    path '/api/v1/notifications' do
      post 'Creates a notification' do
        tags 'Notifications'
        consumes 'application/json', 'application/xml'
        parameter name: :notification, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string },
            description: { type: :string },
            date: { type: :string }
          },
          required: ['title', 'description', 'date']
        }

        response '201', 'notification created' do
          let(:notification) { { title: 'Referral Campaign', description: 'Invite your friends', date: Date.tomorrow.at_noon } }
          run_test!
        end

        response '422', 'invalid request - missing title' do
          let(:notification) { { description: 'Invite your friends', date: Date.tomorrow.at_noon } }
          run_test!
        end

        response '422', 'invalid request - date in past' do
          let(:notification) { { title: 'Referral Campaign', description: 'Invite your friends', date: Date.yesterday.at_noon } }
          run_test!
        end
      end
    end
  end
end
