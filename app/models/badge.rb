class Badge < ApplicationRecord
  has_many :achievements
  has_many :users, through: :achievements
  has_many :test_passages, through: :achievements
end
