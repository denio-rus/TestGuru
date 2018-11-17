class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :title, null: false, index: { unique: true }
      t.text :description, null: false, default: 'Short description'
      t.string :condition, null: false
      t.string :image

      t.timestamps
    end
  end
end
