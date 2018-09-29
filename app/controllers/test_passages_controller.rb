class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]

  def show
    render plain: 'There are no questions in this test yet' unless @test_passage.current_question
  end

  def result; end

  def update
    @test_passage.accept!(params[:answer_ids])
    
    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    result = GitHubClientResponseAdapter.new(@test_passage.current_question)
    
    if result.success? 
      Gist.create(user_id: @test_passage.user.id, question_id: @test_passage.current_question.id, url: result.gist_url, gist_hash: result.gist_hash)
      flash_options = { notice: t('.success.html', url: result.gist_url) }
    else
      flash_options = { alert: t('.failure') }
    end

    redirect_to @test_passage, flash_options
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end  
end
