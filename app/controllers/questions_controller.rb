class QuestionsController < ApplicationController
  before_action :test_question_find

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def show
  end

  def new
    @question = @test.questions.new
  end

  def edit
  end

  def create
    @question = @test.questions.new(question_params)
    
    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def update 
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to @test
  end

  private
  
  def test_question_find
    if params[:id] # если задан этот параметр, значит речь идет не о new, create
      @question = Question.find(params[:id])
      @test = @question.test
    else 
      @test = Test.find(params[:test_id])
    end
  end

  def rescue_with_question_not_found
    render plain: "Question was not found"
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
