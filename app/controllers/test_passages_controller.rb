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
      if @test_passage.success?
        @test_passage.successful = true
        @test_passage.save!
        check_achievement(@test_passage)
      end
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    result = GistQuestionService.new(@test_passage.current_question).call
    
    if result.success? 
      current_user.gists.create(question: @test_passage.current_question, url: result.gist_url)
      flash[:notice] = t('.success', url: result.gist_url)
    else
      flash[:alert] = t('.failure') 
    end

    redirect_to @test_passage
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def check_achievement(test_passage)
    Badge.all.each do |badge|
      test_passage.achievements.create(badge_id: badge.id) if instance_eval(badge.condition)
    end
  end
end
