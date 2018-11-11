class AchievementService
  BADGE_TYPES = %i[all_in_category all_in_level first_attempt successful_tests].freeze
  
  def initialize(test_passage, current_user)
    @test_passage = test_passage
    @current_user = current_user
    @success = false
  end

  def success?
    @success
  end

  def check_all
    Badge.all.each do |badge| 
      if send("check_#{badge.award_type}", badge.condition)
        @current_user.achievements.create(badge_id: badge.id)
        @success = true
      end
    end
  end

  def check_all_in_category(condition)
    Category.find_by(title: condition).tests.ids.sort == @test_passage.category.test_passages.all_successful.where(user: @current_user).pluck(:test_id).uniq.sort
  end

  def check_all_in_level(condition)
    level = @test_passage.test.level
    list = []
    @current_user.test_passages.all_successful.each { |test_passage| list << test_passage.test_id if test_passage.test.level == level}
    Test.where(level: condition.to_i).ids.sort == list.uniq.sort
  end

  def check_first_attempt(condition)
    @test_passage.test_id == Test.find_by(title: condition).id && @test_passage.id == @current_user.test_passages.where(test: @test_passage.test_id).ids.sort.first
  end

  def check_successful_tests(condition)
    @current_user.test_passages.all_successful.count == condition.to_i
  end
end 
 