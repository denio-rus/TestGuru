class User < ApplicationRecord
  def tests_by_level(level)
    Test.joins('JOIN results ON results.test_id = tests.id').where('user_id = :id AND level = :level', id: id, level: level)
  end
end