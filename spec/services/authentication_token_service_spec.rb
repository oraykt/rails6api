require 'rails_helper'

describe AuthenticationTokenService, type: :request do
  describe '.call' do
    it 'returns an authentication token' do
      hmac_secret = 'my$ecretK3y'
      token = described_class.call
      decoded_token = JWT.decode token, hmac_secret, true, { algorithm: 'HS256'}
      expect(decoded_token).to eql([
                                            {"test"=>"blah"},
                                            {"alg"=>"HS256"}
                                          ])
    end
  end
end
