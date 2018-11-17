class AddAwardTypeToBadges < ActiveRecord::Migration[5.2]
  def change
    add_column :badges, :award_type, :integer, null: false
  end
end
