class OrganizationMembership < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  # validates :role, presence: true, inclusion: { in: %w[admin member] }
end
