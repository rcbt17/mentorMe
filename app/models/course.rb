class Course < ApplicationRecord
  belongs_to :user
  has_many :course_subscriptions, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one_attached :poster
  has_many :lessons, dependent: :destroy
  belongs_to :category

  validates :name, presence: true, length: { minimum: 3, maximum: 32 }
  validates :description, presence: true, length: { minimum: 25}
  validates :poster, presence: true

  def calculate_review(course)
    if course.reviews.count.zero?
      return "Not rated yet!"
    else
      sum = 0.0
      course.reviews.each do |review|
        sum += review.stars
      end
      return sum / course.reviews.size
    end
  end

  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
                  against: [:name, :description],
                  using: {
                    tsearch: { prefix: true }
                  }
end
