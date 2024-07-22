require 'jwt'
class PoliciesController < ApplicationController
  before_action :authenticate_user!

  def index
    sleep(1)
    @response = GraphqlService.get_policies(encode_token)
  rescue StandardError => e
    Rails.logger.error("Errors: #{e.message}")
    @error = e.message
    render 'home/error', status: 500
  end

  def search
    policy_id = params[:search]
    @response = GraphqlService.get_policy(encode_token, policy_id)
    if @response["errors"]
      @response = @response["errors"][0]
    else
      @response = @response["data"]["policy"]
    end
  rescue StandardError => e
    Rails.logger.error("Errors: #{e.message}")
    @error = e.message
    render 'home/error', status: 500
  end

  def new
  end

  def create
    begin
      session = create_checkout_session
      response = GraphqlService.create_policy(encode_token, params, session.id, session.url)
      redirect_to policies_path, notice: "Policy sent successfully!" unless response["errors"]
    rescue StandardError => e
      Rails.logger.error("Errors: #{e.message}")
      @error = e.message
      render 'home/error', status: 500
    end
  end

  private

  def create_checkout_session
    Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          price: 'price_1PbRebDpSh2eKSVtBAA7Kl6C',
          quantity: 1,
        }],
        mode: 'payment',
        success_url: payments_success_url,
        cancel_url: payments_cancel_url
      )
  end

  def encode_token
    hmac_secret = ENV['HMAC_SECRET_KEY']
    exp = Time.now.to_i + 4 * 3600
    exp_payload = { email: current_user.email, exp: exp }
    JWT.encode(exp_payload, hmac_secret, 'HS256')
  end
end
