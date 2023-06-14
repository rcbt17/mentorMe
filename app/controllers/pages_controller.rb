class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  include ApplicationHelper

  def home
  end

  def help
  end

  def statistics
    @user = User.find(params[:id])
    @user_type = @user.courses.count.positive? ? "mentor" : "student"
    @total_lessons = calculate_total_lessons
    @total_views = calculate_total_views
    @total_subscribers = calculate_total_subscribers
    @average_reviews = calculate_average_review
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

  def calculate_total_lessons
    total_lessons = 0
    @user.courses.each do |course|
      total_lessons += course.lessons.count
    end
    total_lessons
  end

  def calculate_total_views
    total_views = 0
    @user.courses.each do |course|
      total_views += course.lessons.joins(:user_lesson_views).count
    end
    total_views
  end

  def calculate_total_subscribers
    total_subscribers = 0
    @user.courses.each do |course|
      total_subscribers += CourseSubscription.where(course: course).count
    end
    total_subscribers
  end

  def calculate_average_review
      total_courses = 0
      total_reviews = 0
    @user.courses.each do |course|
      course.reviews.each do |review|
        total_reviews += review.stars
        total_courses += 1
      end
    end
    if total_reviews.zero?
      return "Not rated yet"
    else
      average_reviews = (total_reviews.to_f / total_courses)
        return average_reviews.round(2)
  end

  end
end
