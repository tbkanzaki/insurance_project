module Resolvers
  class PolicyResolver < Resolvers::BaseResolver
    type Types::PolicyType, null: false
    argument :policy_id, Integer, required: true

    def resolve(policy_id:)
      response = HTTParty.get("http://web-api:5000/policies/#{policy_id}")
      if !response.body.blank?
        parsed_body = JSON.parse(response.body)
        {
          policy_id: parsed_body["policy_id"],
          issue_date: parsed_body["issue_date"],
          end_coverage_date: parsed_body["end_coverage_date"],
          insured: {
            name: parsed_body["insured"]["name"],
            cpf:  parsed_body["insured"]["cpf"]
          },
          vehicle:{
            plate: parsed_body["vehicle"]["plate"],
            brand: parsed_body["vehicle"]["brand"],
            model: parsed_body["vehicle"]["model"],
            year: parsed_body["vehicle"]["year"]
          }
        }
      end
    end
  end
end
