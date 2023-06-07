class TopicsController < ApplicationController

  def show
    @topic = Topic.find(params[:id])
    @topics = Topic.all
    @post = Post.new
    @posts = Post.where(topic: @topic).order("id DESC")
    authorize @topic
  end

  def create
    @topic = Topic.new(topic_params)
    authorize @topic
    lesson = Lesson.find(params[:lesson_id])
    @topic.lesson = lesson
    @topic.user = current_user
    if @topic.save
      redirect_to course_lesson_topic_path(lesson.course, lesson, @topic)
    else
      flash.alert = "Please complete all the fields"
      redirect_to course_lesson_path(lesson.course, lesson)
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :content, :timestamp)
  end
end
