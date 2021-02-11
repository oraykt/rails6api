# frozen_string_literal: true

require 'rails_helper'

describe AuthenticationTokenService, type: :request do
  describe '.call' do
    it 'returns an authentication token' do
      expect(described_class.call).to eql('123')
    end
  end
end
