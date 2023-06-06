class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[show edit update destroy]
  before_action :set_course, only: %i[new create]

  def index
    @lessons = Lesson.all
    @lessons = policy_scope(Lesson)
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.course = @course
    authorize @lesson
    if @lesson.save
      redirect_to course_path(@course)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @lesson = Lesson.new
    @course = Course.find(params[:course_id])
    @lesson.course = @course
    authorize @lesson
  end

  def show
    authorize @lesson
    @topic = Topic.new
    @last_topics = Topic.where(lesson: @lesson).order("id DESC").last(10)
    unless subscribed?
      flash['alert'] = "You need to join the course to view it's contents"
      redirect_to course_path(@lesson.course)
    end
  end

  def edit
    authorize @lesson
  end

  def destroy
    @lesson.destroy
    redirect_to lesson_path, status: :see_other
    authorize @lesson
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def lesson_params
    params.require(:lesson).permit(:name, :description, :video, :course_id)
  end

  def subscribed?
     current_user == @lesson.course.user || CourseSubscription.user_subscribed?(current_user, @lesson.course)
  end
end
