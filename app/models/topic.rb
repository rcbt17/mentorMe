class Topic < ApplicationRecord
  belongs_to :lesson
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
end
