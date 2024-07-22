class PaymentsController < ApplicationController
  def success
    redirect_to policies_path, notice: "Purchase Successful"
  end

  def cancel
    redirect_to policies_path, notice: "Purchase Unsuccessful"
  end

  def transmits_police_payment_status
    ActionCable.server.broadcast("PaymentUpdatesChannel", params.to_json)
  end
end
