module Resolvers
  class PolicyResolver < Resolvers::BaseResolver
    type Types::PolicyType, null: false
    argument :policy_id, Integer, required: true

    def resolve(policy_id:)
      base_api_url =  ENV.fetch("BASE_API_URL")
      headers = {"Content-Type" => "application/json", Authorization: "Bearer #{context[:token]}"}

      response = HTTParty.get("#{base_api_url}/policies/#{policy_id}", headers: headers)
      if response.body.blank?
        raise GraphQL::ExecutionError , "Not found! Pocily_id: #{policy_id}"
      else
        begin
          JSON.parse(response.body)
        rescue StandardError => e
          raise GraphQL::ExecutionError.new(e.message)
        end
      end
    end
  end
end
