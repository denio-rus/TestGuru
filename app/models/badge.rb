class Badge < ApplicationRecord
  enum award_type: { all_in_category: 'all_in_category', all_in_level: 'all_in_level', 
                     first_attempt: 'first_attempt', successful_tests: 'successful_tests' }

  has_many :achievements, dependent: :destroy
  has_many :users, through: :achievements

  validates :condition, presence: true, if: :need_condition?
  validates :description, presence: true
  validates :title, uniqueness: true, presence: true

  private

  def need_condition?
    award_type != 'first_attempt'
  end
end
