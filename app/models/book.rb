# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :author

  validates_presence_of :title, :description
end
