class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :title, null: false, index: { unique: true }
      t.integer :award_type, null: false
      t.string :condition, null: false
      t.string :image

      t.timestamps
    end
  end
end
