class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  rolify
  belongs_to :age_group, optional: true
  has_many :organization_memberships
  has_many :organizations, through: :organization_memberships
  has_one :parental_consent

  validates :first_name, :last_name, presence: true
  validates :date_of_birth, presence: true
  validates :email, uniqueness: true

  def minor?
    return false unless date_of_birth
    age = calculate_age
    age < 18
  end

  def kid?
    return false unless date_of_birth
    age = calculate_age
    age < 13
  end

  def can_access_platform?
    return true unless kid?
    
    consent = parental_consent
    return false unless consent
    
    consent.status_approved?
  end

  def active_for_authentication?
    result = super && can_access_platform?
    result
  end

  def inactive_message
    if kid? && !can_access_platform?
      :pending_parental_consent
    else
      super
    end
  end

  private

  def calculate_age
    today = Date.today
    age = today.year - date_of_birth.year
    if today.month < date_of_birth.month || (today.month == date_of_birth.month && today.day < date_of_birth.day)
      age -= 1
    end
    age
  end
end