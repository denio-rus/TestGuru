class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]
  #around_action :set_timer, only: :show, if: :timer?

  def show
    render plain: 'There are no questions in this test yet' unless @test_passage.current_question
  end

  def result; end

  def update
    @test_passage.accept!(params[:answer_ids])
    if @test_passage.completed?
      grant_badges
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
  
  def set_timer
    start_time = Time.now
    yield
    spent_time = Time.now - start_time
    @test_passage.time_spent = spent_time
  end

  def timer?
    @test_passage.timer?
  end

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def grant_badges
    badges = AchievementService.new(@test_passage, current_user).check_all
    if badges.present?
      current_user.badges << badges
      flash.notice = t('.got_badge')
    end
  end
end
