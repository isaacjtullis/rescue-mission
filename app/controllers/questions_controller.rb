require 'pry'
class QuestionsController < ApplicationController
  before_action :require_login, except: [:index, :show, :new]

  def index
    @questions = Question.order(created_at: :asc)
  end

  def show
    @question = Question.find(params[:id])
    @answers = Answer.where(question_id: @question.id)
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      flash[:notice] = "Question was successfully created."
      redirect_to @question
    else
      render :new
      flash[:notice] = "Question was not successful"
    end
  end

  def edit
    @question = Question.find(params[:id])
    if @question.user_id != current_user.id
      flash[:notice] = "You cannot edit a question you did not write."
      redirect_to @question
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:notice] = 'Question was successfully updated.'
      redirect_to @question
    else
      flash[:notice] = 'Question as not updated'
      render :'questions/edit'
    end
  end

  def destroy
    question = Question.find(params[:id])
    if question.user_id != current_user.id
      flash[:notice] = "You cannot delete a question you did not write."
      redirect_to question
    else
      question.destroy
      flash[:notice] = "Question was deleted"
      redirect_to questions_path
    end
  end

  private
    def question_params
      params.require(:question).permit(:title, :description, :user_id)
    end

    def require_login
      unless current_user
        flash[:notice] = "You must be logged in to make changes!"
        redirect_to root_path
      end
    end
end
