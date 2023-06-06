class Review < ApplicationRecord
  belongs_to :course
  validates :stars, numericality: { only_integer: true }
  validates :description, presence: true, length: { in: 6..120 }
end
