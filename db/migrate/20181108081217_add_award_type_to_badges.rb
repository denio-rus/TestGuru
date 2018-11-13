class AddAwardTypeToBadges < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      CREATE TYPE badge_award_type AS ENUM ('all_in_category', 'all_in_level', 'first_attempt', 'successful_tests');
    SQL
    add_column :badges, :award_type, :badge_award_type, null: false
  end

  def down
    remove_column :badges, :award_type
    execute <<-SQL
      DROP TYPE badge_award_type;
    SQL
  end
end
