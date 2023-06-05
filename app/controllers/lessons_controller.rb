class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  def index
    @lessons = Lesson.all
    @lessons = policy_scope(Lesson)
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.user = current_user
    authorize @lesson
  end

  def new
    @lesson = Lesson.new
    authorize @lesson
  end

  def show
    authorize @lesson
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

  def lesson_params
    params.require(:lesson).permit(:name, :description, :video_url, :post_content, :course_id)
  end
end
