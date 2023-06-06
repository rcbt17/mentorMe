class AddCategoryIdToCourses < ActiveRecord::Migration[7.0]
  def change
    add_reference :courses, :category, null: false, foreign_key: true
  end
end
