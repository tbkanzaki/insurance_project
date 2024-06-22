module Resolvers
  class PolicyResolver < Resolvers::BaseResolver
    type Types::PolicyType, null: false
    argument :policy_id, Integer, required: true

    def resolve(policy_id:)
      response = HTTParty.get("http://web-api:5000/policies/#{policy_id}")
      if response.body.blank?
        raise GraphQL::ExecutionError , "Not found pocily_id: #{policy_id}"
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
