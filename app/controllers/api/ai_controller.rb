module Api
  class AiController < ApplicationController
    skip_after_action :verify_authorized
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!, except: :answer

    def answer
      ai_answer = OpenaiService.new(params[:prompt]).call
      render json: { answer: ai_answer }
    end
  end
end
