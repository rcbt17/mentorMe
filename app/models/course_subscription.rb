class CourseSubscription < ApplicationRecord
  belongs_to :user
  belongs_to :course

  def self.user_subscribed?(user, course)
    CourseSubscription.where(user: user, course: course).present?
  end
end
