class Review < ApplicationRecord
  belongs_to :course
  belongs_to :user
  validates :stars, numericality: { only_integer: true }
  validates :description, presence: true, length: { in: 6..120 }

  def self.user_reviewed?(user, course)
    !user.reviews.where(course_id: course.id).count.zero?
  end
end
