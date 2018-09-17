class Admin::QuestionsController < Admin::BaseController
  before_action :test_find, only:  %i[new create]
  before_action :question_find, only: %i[edit update show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def show; end

  def new
    @question = @test.questions.new
  end

  def edit; end

  def create
    @question = @test.questions.new(question_params)
    
    if @question.save
      redirect_to [:admin, @question]
    else
      render :new
    end
  end

  def update 
    if @question.update(question_params)
      redirect_to [:admin, @question]
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to admin_test_path(@question.test)
  end

  private
  
  def test_find
    @test = Test.find(params[:test_id])
  end

  def question_find
    @question = Question.find(params[:id])
  end

  def rescue_with_question_not_found
    render plain: "Question was not found"
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
