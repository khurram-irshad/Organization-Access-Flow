class ParentalConsent < ApplicationRecord
  belongs_to :user

  validates :parent_email, presence: true
  enum status: { pending: "pending", approved: "approved", rejected: "rejected" }
end
