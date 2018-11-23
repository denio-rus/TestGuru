class AddTimeToFinishToTestPassages < ActiveRecord::Migration[5.2]
  def change
    add_column :test_passages, :time_to_finish, :datetime
  end
end
