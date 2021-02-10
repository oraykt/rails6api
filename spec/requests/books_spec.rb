# frozen_string_literal: true

require 'rails_helper'

describe 'Books API', type: :request do
  let(:first_author) { FactoryBot.create(:author, name: 'First Author') }
  let(:second_author) { FactoryBot.create(:author, name: 'Second Author') }

  describe 'GET /books' do
    before do
      FactoryBot.create(:book, title: 'Test Title 1', description: 'Test Description 1', author: first_author)
      FactoryBot.create(:book, title: 'Test Title 2', description: 'Test Description 2', author: second_author)
    end
    it 'returns all books' do
      get '/api/v1/books'
      expect(response).to have_http_status(:ok)
      expect(response_body.size).to eq(2)
      expect(response_body).to eql(
        [
          {
            'id' => 1,
            'title' => 'Test Title 1',
            'description' => 'Test Description 1',
            'author' => 'First Author'
          },
          {
            'id' => 2,
            'title' => 'Test Title 2',
            'description' => 'Test Description 2',
            'author' => 'Second Author'
          }
        ]
      )
    end

    it 'return a subset of books based on limit' do
      get '/api/v1/books', params: { limit: 1 }
      expect(response).to have_http_status(:ok)
      expect(response_body.size).to eq(1)
      expect(response_body).to eql(
        [
          {
            'id' => 1,
            'title' => 'Test Title 1',
            'description' => 'Test Description 1',
            'author' => 'First Author'
          }
        ]
      )
    end

    it 'return a subset of books based on limit and offset' do
      get '/api/v1/books', params: { limit: 1, offset: 1 }
      expect(response).to have_http_status(:ok)
      expect(response_body.size).to eq(1)
      expect(response_body).to eql(
        [
          {
            'id' => 2,
            'title' => 'Test Title 2',
            'description' => 'Test Description 2',
            'author' => 'Second Author'
          }
        ]
      )
    end

    it 'has a max limit of 100' do
      expect(Book).to receive(:limit).with(100).and_call_original
      get '/api/v1/books', params: { limit: 999 }
      expect(response).to have_http_status(:ok)
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
      expect(response_body).to eql(
        {
          'id' => 1,
          'title' => 'Test Title',
          'description' => 'Test Description',
          'author' => 'Test Author'
        }
      )
    end
  end

  describe 'DELETE /books/:id' do
    # book = FactoryBot.create(:book, title: 'Test Title', description: 'Test Description')
    let!(:book) { FactoryBot.create(:book, title: 'Test Title', description: 'Test Description', author: first_author) }
    it 'deletes a book' do
      expect do
        delete "/api/v1/books/#{book.id}"
      end.to change { Book.count }.from(1).to(0)
      expect(response).to have_http_status(:no_content)
    end
  end
end
