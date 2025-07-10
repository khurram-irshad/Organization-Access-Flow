class Content < ApplicationRecord
  belongs_to :organization
  validates :title, :content_rating, presence: true
  validates :content_rating, inclusion: { in: %w[G PG-13 R] }
end