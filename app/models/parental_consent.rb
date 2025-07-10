class ParentalConsent < ApplicationRecord
  belongs_to :user
  validates :parent_email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :status, inclusion: { in: [0, 1, 2] }

  STATUS_PENDING = 0
  STATUS_APPROVED = 1
  STATUS_DENIED = 2

  before_create do
    self.token = SecureRandom.urlsafe_base64(32) while token.blank? || self.class.exists?(token: token)
    self.status = STATUS_PENDING if status.blank?
  end

  def status_pending?
    status == STATUS_PENDING
  end

  def status_approved?
    status == STATUS_APPROVED
  end

  def status_denied?
    status == STATUS_DENIED
  end

  def approved!
    update!(status: STATUS_APPROVED)
  end

  def denied!
    update!(status: STATUS_DENIED)
  end
end