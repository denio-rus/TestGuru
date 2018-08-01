class User < ApplicationRecord
  def tests_by(level)
    taken_test_ids = Result.where(user_id: id).select(:test_id)
    Test.where('level = :level AND id: taken_tests_id', :level, :taken_test_ids)
  end
end
