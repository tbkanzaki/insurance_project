class CreatePolicyWorker
  class << self
    def execute(payload)
      success = true
      policy = nil
      ActiveRecord::Base.transaction do
        begin
          policy = create(payload)
        rescue StandardError => e
          success = false
          puts "Error saving the policy: #{e}"
          raise ActiveRecord::Rollback
        end
      end
      if success && policy
        puts "Policy created successfully! ID: #{policy.id} and Policy: #{payload}"
      end
    end

    private

    def create(payload)
      policy_payload = JSON.parse(payload)
      insured_payload, vehicle_payload = policy_payload.values_at("insured", "vehicle")

      insured = Insured.find_or_initialize_by(cpf: insured_payload['cpf'])
      insured.assign_attributes(**insured_payload)
      insured.save!

      vehicle = Vehicle.find_or_initialize_by(plate: vehicle_payload['plate'])
      vehicle.assign_attributes(**vehicle_payload)
      vehicle.save!

      Policy.create(policy_id: policy_payload['policy_id'],
                    issue_date: policy_payload['issue_date'],
                    end_coverage_date: policy_payload['end_coverage_date'],
                    insured: insured,
                    vehicle: vehicle)
    end
  end
end
