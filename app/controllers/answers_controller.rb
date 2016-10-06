class AnswersController < ApplicationController
    before_action :require_login, except: [:index]
  def index
    @question = Question.find(params[:question_id])
  end

  def new
    @answer = Answer.new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question_id = @question.id

      if @answer.save
        flash[:notice] = "Answer has been saved"
        redirect_to question_path(@question)
      else
        flash[:notice] = "Answer has not been saved"
        render :'questions/show'
      end
  end

  private
    def answer_params
      params.require(:answer).permit(:description)
    end

    def require_login
      unless current_user
        flash[:notice] = "You must be logged in to make changes!"
        redirect_to root_path
      end
    end
end


#questions_path


#redirect start a completely new http request - It is a clean slate
#render you keep the partial object in memory - this way you can view your current memory status

#when you redirect you send to url when you render you send to a file ******

#redirect_back fallback_location: proc { question(@question) }
#add error messages flash error messages and redirect to @question
