class AddCategoryToMovie < ActiveRecord::Migration[6.0]
  def change
    add_reference :movies, :category, null: false, foreign_key: true
  end
end
