module ApplicationHelper
  def calculate_review(course)
    if course.reviews.count.zero?
      return "Not rated yet!"
    else
      sum = 0.0
      course.reviews.each do |review|
        sum += review.stars
      end
      return (sum / course.reviews.size).round(2)
    end
  end
end

