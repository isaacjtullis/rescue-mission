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
