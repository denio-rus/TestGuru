class Badge < ApplicationRecord
  has_many :achievements, dependent: :destroy
  has_many :users, through: :achievements

  validates :condition, :description, presence: true
  validates :title, uniqueness: true, presence: true
end
