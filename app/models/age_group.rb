class AgeGroup < ApplicationRecord
  validates :name, presence: true
  validates :min_age, :max_age, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :max_age, numericality: { greater_than: :min_age }, if: -> { min_age.present? }
end
