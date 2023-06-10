class CreateUserLessonViews < ActiveRecord::Migration[7.0]
  def change
    create_table :user_lesson_views do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
