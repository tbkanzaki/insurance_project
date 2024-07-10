class CreatePolicyWorker
  class << self
    def execute(data, token)
      begin
        policy_data = JSON.parse(data)
        decode_token(token)

        success = true
        policy = nil
        ActiveRecord::Base.transaction do
          begin
            policy = create(policy_data)
          rescue StandardError => e
            success = false
            puts "Error saving the policy: #{e}"
            raise ActiveRecord::Rollback
          end
        end
      rescue StandardError => e
        success = false
        puts "Authorization denied: #{e}"
      end
      if success && policy
        puts "Policy created successfully! ID: #{policy.id} and Policy: #{policy_data}"
      end
    end

    private

    def decode_token(token)
      hmac_secret = ENV['HMAC_SECRET_KEY']
      JWT.decode token, hmac_secret, true, { algorithm: 'HS256' }
    end

    def create(policy_payload)
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
