class AchievementService

  def initialize(test_passage, current_user)
    @test_passage = test_passage
    @current_user = current_user
  end

  def check_all
    return unless @test_passage.success?

    Badge.all.select { |badge| send("check_#{badge.award_type}?", badge.condition) }
  end

  #private

  def check_all_in_category?(title)
    return unless @test_passage.category.title == title

    all_tests_in_category = Category.find_by(title: title).tests.ids.sort
    test_passed_in_category = successful_passages.joins(:category).where('categories.title = ?', title).select(:test_id).distinct.order(:test_id).pluck(:test_id)
    all_tests_in_category == test_passed_in_category
  end

  def check_all_in_level?(level_number)
    level = @test_passage.test.level
    return unless level == level_number.to_i

    successful_tests_in_level = successful_passages.joins(:test).where('tests.level = ?', level).select(:test_idf).distinct.order(:test_id).pluck(:test_id)
    Test.where(level: level_number.to_i).ids.sort == successful_tests_in_level
  end

  def check_first_attempt?(_reserved)
    @test_passage.user.tests.where(id: @test_passage.test_id).count == 1
  end

  def check_successful_tests?(number)
    successful_passages.count == number.to_i
  end

  def successful_passages
    @successful_passages ||= @current_user.test_passages.all_successful
  end
end
