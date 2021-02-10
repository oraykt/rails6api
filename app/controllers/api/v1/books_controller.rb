module Api
  module V1
    class BooksController < ApplicationController
      def index
        books = Book.all

        render json: BooksRepresenter.new(books).as_json
      end

      def create
        author = Author.create!(author_params)
        book = Book.new(book_params.merge(author_id: author.id))

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