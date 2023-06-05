class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.all
    policy_scope(Course)
  end

  def show
    authorize @course
  end

  private
  def set_course
    @course = Course.find(params[:id])
  end
end
