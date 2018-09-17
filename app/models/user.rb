class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable,
         :trackable,
         :confirmable, 
         :validatable
 
  has_many :test_passages
  has_many :created_tests, class_name: 'Test', inverse_of: :author, dependent: :nullify 
  has_many :tests, through: :test_passages

  # validates :email, uniqueness: true, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/, message: 'not correct.' }

  def tests_by_level(level)
    tests.where(level: level) 
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test: test)
  end
end 