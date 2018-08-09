class Test < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id', inverse_of: :created_tests
  belongs_to :category
  has_many :tests_users
  has_many :users, through: :tests_users
  has_many :questions

  def self.all_in_category(category)
    joins(:category).where(categories: { title: category }).order(title: :asc)
  end
end