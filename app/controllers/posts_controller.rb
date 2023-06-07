class PostsController < ApplicationController
  def create
    @post = Post.new(topic_params)
    @post.votes = 1
    @post.user = current_user
    @post.topic = Topic.find(params[:post][:topic_id])
    authorize @post
    unless @post.save
      flash.alert = "Please complete all the fields"
    end
    redirect_to course_lesson_topic_path(@post.topic.lesson.course, @post.topic.lesson, @post.topic)
  end

  private

  def topic_params
    params.require(:post).permit(:content)
  end
end
