# frozen_string_literal: true

require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /authenticate' do
    it 'authenticates the client' do
      post '/api/v1/authenticate', params: { username: 'test_user', password: 'test_passw0rd.' }

      expect(response).to have_http_status(:created)
      expect(response_body).to eql({
                                     'token' => '123'
                                   })
    end
    it 'returns error when username is missing' do
      post '/api/v1/authenticate', params: { password: 'test_passw0rd.' }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns error when password is missing' do
      post '/api/v1/authenticate', params: { username: 'test_user' }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
