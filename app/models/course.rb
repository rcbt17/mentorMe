class Course < ApplicationRecord
  belongs_to :user
  has_many :course_subscriptions, dependent: :destroy
  has_many :review
  has_one_attached :poster
  has_many :lesson, dependent: :destroy
  belongs_to :category

  validates :name, presence: true, length: { minimum: 3, maximum: 32 }
  validates :description, presence: true, length: { minimum: 25, maximum: 500 }
  validates :poster, presence: true
end
