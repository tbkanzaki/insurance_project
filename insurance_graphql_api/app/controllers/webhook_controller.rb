class WebhookController < ApplicationController
  ENDPOINT_SECRET = ENV['ENDPOINT_SECRET']

  def execute
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil
    begin
        event = Stripe::Webhook.construct_event(
            payload, sig_header, ENDPOINT_SECRET
        )
        case event.type
        when "checkout.session.completed"
          session = event.data.object
          payment_payload = { payment_id: session.id }

          queue = $channel.queue('payment')
          queue.publish(payment_payload.to_json)
        else
            puts "Unhandled event type: #{event.type}"
        end
    rescue JSON::ParserError => e
        puts "ParserError: Invalid payload :  #{e}"
        status 400
        return
    rescue Stripe::SignatureVerificationError => e
        puts "SignatureVerificationError:  Invalid signature : #{e}"
        status 400
        return
    end
  end
end
