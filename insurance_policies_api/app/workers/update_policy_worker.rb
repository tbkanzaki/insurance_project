class UpdatePolicyWorker
  class << self
    def execute(data)
      begin
        success = true
        policy = nil
        policy_data = JSON.parse(data)
        payment_id = policy_data["payment_id"]
        policy = update_status(payment_id)
      rescue StandardError => e
        success = false
        puts "Error: #{e}"
      end
      if success && policy
        puts "Policy updated successfully! Policy Status: #{policy.payment_status}"
      end
    end

    private

    def update_status(payment_id)
      policy = Policy.find_by(payment_id: payment_id)
      policy.update(payment_status: 1)
      policy
    end
  end
end
