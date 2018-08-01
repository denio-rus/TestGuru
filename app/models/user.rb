class User < ApplicationRecord


  def tests_by(level)
    list = []
    User.where(id: id).test_taken.each do |test_id|
    list << Test.find_by('level = :level AND id = :test_id', :level, :test_id)
    end
    list.compact!
  end
end
