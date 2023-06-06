class Lesson < ApplicationRecord
  belongs_to :course
  has_one_attached :video
  has_many :topics, dependent: :destroy
  validates :name, presence: true, length: { minimum: 2 }
  validates :description, presence: true
  validates :video, presence: true
end
