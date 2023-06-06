class Category < ApplicationRecord
  has_many :courses
  validates :category, presence: true
end
