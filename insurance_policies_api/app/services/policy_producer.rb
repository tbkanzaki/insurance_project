require 'bunny'
require 'securerandom'
class PolicyProducer
	def initialize
		policy_id = SecureRandom.random_number(1_000_000)
		@policy_data = {
										"policy_id": policy_id,
										"issue_date": "2024-01-01",
										"end_coverage_date": "2025-01-01",
										"insured": {
										"name": "Joao Silva",
										"cpf": "001.002.003-90"
										},
										"vehicle": {
										"brand": "Fiat",
										"model": "Uno 1.0",
										"year": "1996",
										"plate": "ABC-1234"
										}
										}.to_json
	end

  def publish
    $channel.default_exchange.publish(@policy_data, routing_key: $queue.name)
    puts " [x] Sent #{@policy_data}"
  end
end
