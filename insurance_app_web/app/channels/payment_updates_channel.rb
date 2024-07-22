class PaymentUpdatesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "PaymentUpdatesChannel"
  end
end
