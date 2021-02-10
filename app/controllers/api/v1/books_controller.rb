module Api
  module V1
    class BooksController < ApplicationController
      def index
        render json: Book.all
      end

      def create
        book = Book.new(book_params)

        if book.save
          render json: book, status: :created
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

      def book_params
        params.require(:book).permit(:title, :description)
      end

      def find_book
        Book.find(params.require(:id))
      end
    end
  end
end