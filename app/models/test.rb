class Test < ApplicationRecord
  belongs_to :category

  def self.all_in_category(category)
    self.joins('JOIN categories ON category_id = categories.id').where('categories.title = :category', category: category)
  end
end
