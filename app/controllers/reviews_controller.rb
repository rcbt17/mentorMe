class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.course = Course.find(params[:course_id])
    @review.user_id = current_user.id
    authorize @review
    if @review.save
      flash[:notice] = "Thanks for your review!"
    else
      flash[:alert] = "Complete all the fields"
    end
    redirect_to course_path(@review.course)
  end

  private

  def review_params
    params.require(:review).permit(:stars, :description)
  end
end
