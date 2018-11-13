class AchievementService

  def initialize(test_passage, current_user)
    @test_passage = test_passage
    @current_user = current_user
  end

  def check_all
    return unless @test_passage.success?

    Badge.all.select do |badge| 
      if badge.award_type == 'first_attempt'
        send("check_#{badge.award_type}?")
      else
        send("check_#{badge.award_type}?", badge.condition)
      end
    end
  end
  
  private

  def check_all_in_category?(condition)
    return unless @test_passage.category.title == condition

    all_tests_in_category = Category.find_by(title: condition).tests.ids.sort
    test_passed_in_category = select_successful_passages.joins(:category).where('categories.title = ?', condition).pluck(:test_id)
    all_tests_in_category == test_passed_in_category.uniq.sort
  end

  def check_all_in_level?(condition)
    level = @test_passage.test.level
    return unless level == condition.to_i
   
    successful_tests_in_level = select_successful_passages.joins(:test).where('tests.level = ?', level).pluck(:test_id)
    Test.where(level: condition.to_i).ids.sort == successful_tests_in_level.uniq.sort
  end

  def check_first_attempt?
    @test_passage.id == @current_user.test_passages.where(test: @test_passage.test_id).ids.sort.first
  end

  def check_successful_tests?(condition)
    select_successful_passages.count == condition.to_i
  end

  def select_successful_passages
    @current_user.test_passages.all_successful
  end
end 
 