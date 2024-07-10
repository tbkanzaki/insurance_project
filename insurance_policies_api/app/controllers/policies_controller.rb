class PoliciesController < ApplicationController
  before_action :authenticate_token
  before_action :fetch_policy, only: %i[show]

  def index
    @policies = Policy.includes(:insured, :vehicle).order(policy_id: :asc)
    render json: format_policies(@policies), include: [:insured, :vehicle]
  end

  def show
    render json: format_json(@policy), status: :ok
  end

  private

  def fetch_policy
    @policy = Policy.includes(:insured, :vehicle).find_by(policy_id: params[:id])
    head :not_found if @policy.blank?
  end

  def format_json(p)
    {
      policy_id: p.policy_id,
      issue_date: p.issue_date,
      end_coverage_date: p.end_coverage_date,
      insured: {
        name: p.insured.name,
        cpf: p.insured.cpf,
      },
      vehicle: {
        plate: p.vehicle.plate,
        brand: p.vehicle.brand,
        model: p.vehicle.model,
        year: p.vehicle.year
      }
    }
  end

  def format_policies(policies)
    policies.each do |p|
      {
        policy_id: p.policy_id,
        issue_date: p.issue_date,
        end_coverage_date: p.end_coverage_date,
        insured: {
          name: p.insured.name,
          cpf: p.insured.cpf
        },
        vehicle: {
          plate: p.vehicle.plate,
          brand: p.vehicle.brand,
          model: p.vehicle.model,
          year: p.vehicle.year
        }
      }
    end
  end
end
