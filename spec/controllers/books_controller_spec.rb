# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  describe 'GET index' do
    it 'has a max limit of 100' do
      expect(Book).to receive(:limit).with(100).and_call_original
      get :index, params: { limit: 999 }
    end
  end

  describe 'POST create' do
    let(:book_title) { 'eloquent ruby' }
    let(:book_description) { 'perfect' }
    let(:author_name) { 'Test Author' }
    it 'calls UpdateSkuJob with correct params' do
      expect(UpdateSkuJob).to receive(:perform_later).with(book_title, book_description)
      post :create, params: {
        author: {
          name: author_name
        },
        book: {
          title: book_title,
          description: book_description
        }
      }
    end
  end
end
