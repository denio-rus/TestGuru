class Badge < ApplicationRecord
  attr_accessor :choice, :subject

  has_many :achievements, dependent: :destroy
  has_many :users, through: :achievements
  has_many :test_passages, through: :achievements

  validates :title, :condition, :description, presence: true
  validates :title, :condition, uniqueness: true

  before_validation :make_the_rule

  def make_the_rule
    case choice.to_i
    when 1
      self.condition = "Category.find_by(title: '#{subject}').tests.ids.sort == test_passage.category.test_passages.all_successful.where(user: current_user).pluck(:test_id).uniq.sort"
    when 2
      self.condition = "level = test_passage.test.level
      list = []
      current_user.test_passages.all_successful.each { |test_passage| list << test_passage.test.id if test_passage.test.level == level}
      Test.where(level: #{subject}.to_i).ids.sort == list.uniq.sort"
    when 3
      self.condition = "test_passage.test.id == Test.find_by(title: '#{subject}').id && test_passage.id == current_user.test_passages.where(test: test_passage.test).ids.sort.first"
    when 4
      self.condition = "current_user.test_passages.all_successful.count == #{subject}.to_i"
    end
  end
end
