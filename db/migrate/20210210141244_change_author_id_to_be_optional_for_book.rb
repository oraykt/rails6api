# frozen_string_literal: true

class ChangeAuthorIdToBeOptionalForBook < ActiveRecord::Migration[6.1]
  def change
    change_column :books, :author_id, :integer, null: true
  end
end
