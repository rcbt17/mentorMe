class CourseSubscriptionsController < ApplicationController
  before_action :set_course, only: %i[create]


  helper_method :is_user_subscribed?

  def create
    @subscription = CourseSubscription.new(user: current_user, course: @course)
    authorize @subscription
    unless CourseSubscription.user_subscribed?(current_user, @course) || current_user == @course.user
      if @subscription.save
        redirect_to course_path(@course)
      else
        render :new, status: :unprocessable_entity
      end
    else
      flash[:alert] = "You are already enrolled to this course"
      redirect_to course_path(@course)
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end
end
