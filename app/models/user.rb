class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one :parental_consent

  has_many :organization_memberships
  has_many :organizations, through: :organization_memberships
  
  belongs_to :age_group, optional: true
  validates :date_of_birth, presence: true

  after_validation :set_age_group, on: [:create, :update]

  def age
    ((Date.today - date_of_birth) / 365.25).to_i
  end

  def minor?
    age < 18
  end

  private

  def set_age_group
    self.age_group = AgeGroup.find_by("min_age <= ? AND max_age >= ?", age, age)
  end
end