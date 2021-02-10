# frozen_string_literal: true

require 'rails_helper'

describe 'Books API', type: :request do
  describe 'GET /books' do
    it 'returns all books' do
      author = FactoryBot.create(:author, name: 'Test Author')
      FactoryBot.create(:book, title: 'Test Title 1', description: 'Test Description 1', author_id: author.id)
      FactoryBot.create(:book, title: 'Test Title 2', description: 'Test Description 2', author_id: author.id)

      get '/api/v1/books'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /books' do
    it 'create a new book' do
      expect do
        post '/api/v1/books',
             params: { book: { title: 'Test Title', description: 'Test Description' }, author: { name: 'Test Author' } }
      end.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      expect(Author.count).to eql(1)
    end
  end

  describe 'DELETE /books/:id' do
    # book = FactoryBot.create(:book, title: 'Test Title', description: 'Test Description')
    let!(:book) { FactoryBot.create(:book, title: 'Test Title', description: 'Test Description') }
    it 'deletes a book' do
      expect do
        delete "/api/v1/books/#{book.id}"
      end.to change { Book.count }.from(1).to(0)
      expect(response).to have_http_status
    end
  end
end
