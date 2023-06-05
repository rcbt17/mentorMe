class Lesson < ApplicationRecord
  belongs_to :course
  validates :name, presence: true, length: { minimum: 2 }
  validates :description, presence: true
  validates :video_url, presence: true
  validates :post_content, presence: true
end
