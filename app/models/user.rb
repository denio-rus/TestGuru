class User < ApplicationRecord
 
  has_many :test_passages
  has_many :created_tests, class_name: 'Test', inverse_of: :author, dependent: :nullify 
  has_many :tests, through: :test_passages

  validates :email, uniqueness: true, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/, message: 'not correct.' }

  has_secure_password

  def tests_by_level(level)
    tests.where(level: level) 
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test: test)
  end
end 