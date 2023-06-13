class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  include ApplicationHelper


  def home
  end

  def help
  end

  def statistics
    @user = User.find(params[:id])
    @user_type = "student"
    if @user.courses.count.positive?
      @user_type = "mentor"
    else
      user_type = "student"
    end
  end

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
