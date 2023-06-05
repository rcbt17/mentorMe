class Course < ApplicationRecord
  belongs_to :user
  has_many :users, through: :course_subscriptions
  has_one_attached :poster

  validates :name, presence: true, length: { minimum: 3, maximum: 32 }
  validates :description, presence: true, length: { minimum: 25, maximum: 500 }
  validates :poster, presence: true
  has_many :lesson
end
