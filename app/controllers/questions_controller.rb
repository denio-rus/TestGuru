class QuestionsController < ApplicationController
  before_action :test_find

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    render partial: 'question', collection: @test.questions
  end

  def show
    @question = @test.questions.find(params[:id])
    render "show"
  end

  def new
  end

  def create
    Question.create(body: params[:question][:body], test_id: params[:test_id])
    render plain: "Question was created"
  end

  def destroy
    Question.find(params[:id]).destroy
    render html: '<h3>The question has been deleted.</h3>'.html_safe
  end

  private

  def test_find
    @test = Test.find(params[:test_id])
  end

  def rescue_with_question_not_found
    render plain: "Question was not found"
  end
end
