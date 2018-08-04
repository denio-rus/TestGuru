class Test < ApplicationRecord
  belongs_to :author
  belongs_to :category
  has_many :tests_users  
  has_many :users, through: :tests_users
  has_many :questions

  def self.all_in_category(category)
    self.joins(:category).where(categories:{title: category}).order(title: :asc)
  end
end