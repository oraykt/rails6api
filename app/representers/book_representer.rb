# frozen_string_literal: true

class BookRepresenter
  def initialize(book)
    @book = book
  end

  def as_json
    {
      id: book.id,
      title: book.title,
      description: book.description,
      author: book.author.name
    }
  end

  private

  attr_reader :book
end
