class Course < ApplicationRecord
  belongs_to :user
  has_many :course_subscriptions, dependent: :destroy
<<<<<<< HEAD
  belongs_to :category
=======
>>>>>>> 11a638185a6645626b8a06974ae54fed0f86da97
  has_one_attached :poster
  has_many :lesson, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 32 }
  validates :description, presence: true, length: { minimum: 25, maximum: 500 }
  validates :poster, presence: true
end
