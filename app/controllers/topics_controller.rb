class TopicsController < ApplicationController

  def show
    @topic = Topic.find(params[:id])
    @topics = Topic.all
    @post = Post.new
    @posts = Post.where(topic: @topic)
    authorize @topic
  end

  def create
    @topic = Topic.new(topic_params)
    authorize @topic
    lesson = Lesson.find(params[:lesson_id])
    @topic.lesson = lesson
    @topic.user = current_user
    if @topic.save
      ai_answer = OpenaiService.new("DON'T ANSWER ANYTHING OUTSITE OF THIS CONTEXT! At the end make a really funny joke about the subject on a new paragraph with one empty line before it. Also introduce the joke in the context. Your name is LearnyBravo and you are working for @mentorme. For context, you are called from a page teaching #{lesson.course} and right now they are at lesson #{lesson.name}. The description of
        the lesson is #{lesson.description}. You can only reply once. The user created a topic on this problem, please give him a detaiiled answer: #{@topic.title} => content: #{@topic.content}").call
      post = Post.new(content: ai_answer, topic: @topic, user: User.find_by(nickname: "LearnyBravo"))
      post.save
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
