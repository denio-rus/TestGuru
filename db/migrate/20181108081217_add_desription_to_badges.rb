class AddDesriptionToBadges < ActiveRecord::Migration[5.2]
  def change
    add_column :badges, :description, :text, null: false, default: 'Short description'
  end
end
