class Policy < ApplicationRecord
  belongs_to :vehicle
  belongs_to :insured

  enum payment_status: { "Awaiting payment": 0, "Paid": 1}
end
