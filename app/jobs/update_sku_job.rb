# frozen_string_literal: true
require('net/http')

class UpdateSkuJob < ApplicationJob
  queue_as :default

  def perform(book_title, book_description)
    uri = URI('http://localhost:4567/update_sku')
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    req.body = { sku: '123', title: book_title, description: book_description }.to_json
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
  end
end