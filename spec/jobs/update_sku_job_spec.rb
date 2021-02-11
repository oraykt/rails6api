require 'rails_helper'

RSpec.describe UpdateSkuJob, type: :job do
  it 'calls SKU service with correct params' do
    allow(Net::HTTP).to receive(:start).and_return(true)
    described_class.perform_now('eloquent ruby', 'perfect')
  end
end
