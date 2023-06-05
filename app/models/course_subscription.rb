class CourseSubscription < ApplicationRecord
  belongs_to :user
  belongs_to :course
end
