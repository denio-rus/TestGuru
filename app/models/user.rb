class User < ApplicationRecord
  def tests_by_level(level)
    Result.where(user_id: id)
  end
end
