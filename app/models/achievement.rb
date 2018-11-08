class Achievement < ApplicationRecord
  belongs_to :badge
  belongs_to :test_passage
  has_one :user, through: :test_passage
  has_one :test, through: :test_passage
end