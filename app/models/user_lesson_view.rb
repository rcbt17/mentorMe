class UserLessonView < ApplicationRecord
  belongs_to :user
  belongs_to :lesson
  validates :user, presence: true
  validates :lesson, presence: true

  def self.user_viewed?(user, lesson)
    UserLessonView.where(user: user, lesson: lesson).present?
  end
end
