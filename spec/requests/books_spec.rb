require 'rails_helper'

describe 'Books API', type: :request do
  describe 'GET /books' do
    it 'returns all books' do
      FactoryBot.create(:book, title: 'Test Title 1', description: 'Test Description 1')
      FactoryBot.create(:book, title: 'Test Title 2', description: 'Test Description 2')

      get '/api/v1/books'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /books' do
    it 'create a new book' do
      expect do
        post '/api/v1/books', params: { book: { title: 'Test Title',description: 'Test Description' } }
      end.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /books/:id' do
    # book = FactoryBot.create(:book, title: 'Test Title', description: 'Test Description')
    let!(:book) { FactoryBot.create(:book, title: 'Test Title', description: 'Test Description') }
    it 'deletes a book' do
      expect {
        delete "/api/v1/books/#{book.id}"
      }.to change { Book.count }.from(1).to(0)
    end
  end
end