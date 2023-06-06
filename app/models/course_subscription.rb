class CourseSubscription < ApplicationRecord
  belongs_to :user
  belongs_to :course

  def self.user_subscribed?(user, course)
    !user.course_subscriptions.where(course_id: course.id, user_id: user.id).count.zero?
  end
end
