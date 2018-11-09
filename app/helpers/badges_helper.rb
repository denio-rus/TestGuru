module BadgesHelper
  def make_the_rule(choice, subject)
    case choice
    when 1
      "Category.find_by(title: #{subject}).tests.ids.sort == test_passage.category.test_passages.all_successful.where(user: current_user).pluck(:test_id).uniq.sort"
    when 2
      "level = test_passage.test.level
      list = []
      current_user.test_passages.all_successful.each { |test_passage| list << test_passage.test.id if test_passage.test.level == level}
      Test.where(level: #{subject}).ids.sort == list.uniq.sort"
    when 3
      "test_passage.test.id == Test.find_by(title: #{subject}).id && test_passage.id == current_user.test_passages.where(test: test_passage.test).ids.sort.first"
    when 4
      "current_user.test_passages.all_successful.count == #{subject}"
    end
  end
end
