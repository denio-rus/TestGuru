class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :title, null: false
      t.string :award_type, null: false
      t.string :condition, null: false
      t.string :image
      t.index  :title, unique: true

      t.timestamps
    end
  end
end
