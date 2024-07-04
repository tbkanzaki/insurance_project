class PoliciesController < ApplicationController
  before_action :authenticate_user!

  def index
    @response = GraphqlService.get_policies
  rescue StandardError => e
    Rails.logger.error("Errors: #{e.message}")
    @error = e.message
    render 'home/error', status: 500
  end

  def search
    policy_id = params[:search]
    @response = GraphqlService.get_policy(policy_id)
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
      response = GraphqlService.create_policy(params)
      redirect_to policies_path, notice: "Policy sent successfully!" unless response["errors"]
    rescue StandardError => e
      Rails.logger.error("Errors: #{e.message}")
      @error = e.message
      render 'home/error', status: 500
    end
  end
end
