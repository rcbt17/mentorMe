class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.all
    policy_scope(Course)
  end

  def show
    authorize @course
    if user_signed_in?
      @course_subscriptions = current_user.course_subscriptions
    else
      @course_subscriptions = false
    end
    @lessons = Lesson.where(course: @course)
    @review = Review.new
    @reviews = Review.all.where(course: @course).order("id DESC").first(10)

  end

  def new
    @course = Course.new
    @categories = Category.all
    authorize @course
  end

  def create
    @course = Course.new(course_params.except(:category))
    category = Category.find(params[:course][:category])
    @course.category = category
    @course.user = current_user
    authorize @course
    if @course.save
      redirect_to course_path(@course)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @course
  end

  def update
    authorize @course
    if @course.update(course_params)
      redirect_to course_path(@course)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @course
    @course.destroy
    flash[:alert] = "You have successfully deleted a course!"
    redirect_to courses_path, status: :see_other
  end


  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :poster, :category)
  end
end
