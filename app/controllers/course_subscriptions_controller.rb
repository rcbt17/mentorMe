class CourseSubscriptionsController < ApplicationController
  before_action :set_course, only: %i[create destroy]


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

  def destroy
    @subscription = CourseSubscription.where(user: current_user, course: @course)
    authorize @subscription
    @subscription.first.destroy
    @user_lesson_views = UserLessonView.where(user: current_user, lesson: @course.lessons)
    @user_lesson_views.destroy_all
    flash[:notice] = "You have sucessfully unsubscribed from this course"
    redirect_to course_path(@course)
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end
end
