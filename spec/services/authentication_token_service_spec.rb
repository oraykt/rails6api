require 'rails_helper'

describe AuthenticationTokenService, type: :request do
  describe '.call' do

    it 'returns an authentication token' do
      token = described_class.call
      decoded_token = JWT.decode(
        token,
        described_class::HMAC_SECRET,
        true,
        { algorithm: described_class::ALGORITHM_TYPE })
      expect(decoded_token).to eql([
                                            {"test"=>"blah"},
                                            {"alg"=>described_class::ALGORITHM_TYPE}
                                          ])
    end
  end
end
