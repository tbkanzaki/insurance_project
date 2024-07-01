module Resolvers
  class PoliciesResolver < Resolvers::BaseResolver
    type [Types::PolicyType], null: false

    def resolve
      response = HTTParty.get("http://web-api:5000/policies")
      JSON.parse(response.body)
      # if response.body.blank?
      #   raise GraphQL::ExecutionError , "No records"
      # else
      #   begin
      #     JSON.parse(response.body)
      #   rescue StandardError => e
      #     raise GraphQL::ExecutionError.new(e.message)
      #   end
      # end
    end
  end
end
