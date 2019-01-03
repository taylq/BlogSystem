class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :blog

  validates :content, presence: true

  default_scope -> {order(created_at: :desc)}
end
