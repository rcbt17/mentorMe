class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
    if params[:category].present?
      category = Category.where(category: params[:category])
    end
    if params[:query].present?
      if params[:category].present?
        @courses = Course.search_by_name_and_description(params[:query]).where(category: category)
      else
        @courses = Course.search_by_name_and_description(params[:query])
      end
    else
      if params[:category].present?
        @courses = Course.where(category: category)
      else
        @courses = Course.all
      end
    end
    policy_scope(Course)
  end

  def show
    authorize @course
    if user_signed_in?
      @course_subscriptions = current_user.course_subscriptions
    else
      @course_subscriptions = false
    end
    @highest_viewed = UserLessonView.where(user: current_user, lesson: @course.lessons).order("id DESC").first
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
