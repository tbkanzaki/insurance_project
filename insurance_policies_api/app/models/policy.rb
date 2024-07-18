class Policy < ApplicationRecord
  belongs_to :vehicle
  belongs_to :insured

  enum payment_status: { awaiting_payment: 0, paid: 1}
end
