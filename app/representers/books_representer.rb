# frozen_string_literal: true

class BooksRepresenter
  def initialize(books)
    @books = books
  end

  def as_json
    books.map do |book|
      {
        id: book.id,
        title: book.title,
        description: book.description,
        author: book.author.name
      }
    end
  end

  private

  attr_reader :books
end
