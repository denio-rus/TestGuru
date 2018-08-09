class User < ApplicationRecord
  has_many :tests_users
  has_many :created_tests, class_name: 'Test', inverse_of: :author, dependent: :nullify 
  has_many :tests, through: :tests_users

  validates :username, presence: true

  scope :tests_by_level, -> { tests.where(level: level) }
end