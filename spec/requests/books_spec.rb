require 'rails_helper'

describe 'Books API', type: :request do

  it 'returns all books' do
    FactoryBot.create(:book, title: 'Test Title 1', description: 'Test Description 1')
    FactoryBot.create(:book, title: 'Test Title 2', description: 'Test Description 2')
    get '/api/v1/books'

    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body).size).to eq(2)
  end
end