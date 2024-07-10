module Resolvers
  class PoliciesResolver < Resolvers::BaseResolver
    type [Types::PolicyType], null: false

    def resolve
      base_api_url =  ENV.fetch("BASE_API_URL")
      headers = {"Content-Type" => "application/json", Authorization: "Bearer #{context[:token]}"}

      response = HTTParty.get("#{base_api_url}/policies", headers: headers)
      JSON.parse(response.body)
    end
  end
end
