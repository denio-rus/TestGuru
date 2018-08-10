class Test < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id', inverse_of: :created_tests
  belongs_to :category
  has_many :tests_users
  has_many :users, through: :tests_users
  has_many :questions

  validates :title, presence: true, uniqueness: { scope: :level, case_sensetive: false }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :easy, -> { where(level: 0..1) }
  scope :normal, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }

  def self.all_in_category(category)
    joins(:category).where(categories: { title: category }).order(title: :asc)
  end
end