# frozen_string_literal: true

module Api
  module V1
    class BooksController < ApplicationController
      MAX_PAGINATION_LIMIT = 100

      def index
        books = Book.limit(limit).offset(params[:offset])

        render json: BooksRepresenter.new(books).as_json
      end

      def create
        author = Author.create!(author_params)
        book = Book.new(book_params.merge(author_id: author.id))
        UpdateSkuJob.perform_later(book_params[:title], book_params[:description])

        if book.save
          render json: BookRepresenter.new(book).as_json, status: :created
        else
          render json: book.errors, status: :unprocessable_entity
        end
      end

      def destroy
        book = find_book
        book.destroy!

        head :no_content
      end

      private

      def limit
        [
          params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i,
          MAX_PAGINATION_LIMIT
        ].min
      end

      def author_params
        params.require(:author).permit(:name)
      end

      def book_params
        params.require(:book).permit(:title, :description)
      end

      def find_book
        Book.find(params.require(:id))
      end
    end
  end
end
