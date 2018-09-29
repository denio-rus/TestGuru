class Gist < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :user_id, :question_id, :gist_hash, :url, presence: true
end
