class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :title, unique: true, null: false
      t.string :condition, unique: true, null: false
      t.string :image

      t.timestamps
    end
  end
end
