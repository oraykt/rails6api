# frozen_string_literal: true

require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /authenticate' do
    let(:user) { FactoryBot.create(:user, username: 'test_user') }
    let(:token) {AuthenticationTokenService.call(1)}
    it 'authenticates the client' do
      post '/api/v1/authenticate', params: { username: user.username, password: 'test_passw0rd.' }

      expect(response).to have_http_status(:created)
      expect(response_body).to eql({
                                     'token' => token
                                   })
    end
    it 'returns error when username is missing' do
      post '/api/v1/authenticate', params: { password: 'test_passw0rd.' }

      expect(response).to have_http_status(:unprocessable_entity)
      # expect(response_body).to eql({
      #                                'error' => 'param is missing or the value is empty: password'
      #                              })
    end

    it 'returns error when password is missing' do
      post '/api/v1/authenticate', params: { username: user.username }

      expect(response).to have_http_status(:unprocessable_entity)
      # expect(response_body).to eql({
      #                                'error' => 'param is missing or the value is empty: username'
      #                              })
    end
  end
end
