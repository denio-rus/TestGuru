class Badge < ApplicationRecord
  enum award_type: { all_in_category: 1, all_in_level: 2, 
                     first_attempt: 3, successful_tests: 4 }

  has_many :achievements, dependent: :destroy
  has_many :users, through: :achievements

  validates :condition, presence: true, unless: :first_attempt?
  validates :description, presence: true
  validates :title, uniqueness: true, presence: true
end
