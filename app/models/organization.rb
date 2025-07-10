class Organization < ApplicationRecord
  resourcify

  has_many :organization_memberships, dependent: :destroy
  has_many :users, through: :organization_memberships
  has_many :contents

  validates :name, presence: true, uniqueness: true
end
