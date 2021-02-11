# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateSkuJob, type: :job do
  let(:book_title) { 'eloquent ruby' }
  let(:book_description) { 'perfect' }

  before do
    allow(Net::HTTP).to receive(:start).and_return(true)
  end

  it 'calls SKU service with correct params' do
    expect_any_instance_of(Net::HTTP::Post).to receive(:body=).with(
      { sku: '123', title: book_title, description: book_description }.to_json
    )
    described_class.perform_now(book_title, book_description)
  end
end
