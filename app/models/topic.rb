class Topic < ApplicationRecord
  belongs_to :lesson
  belongs_to :user
  has_many :posts, dependent: :destroy
  validates :title, presence: true
  validates :content, presence: true
end
