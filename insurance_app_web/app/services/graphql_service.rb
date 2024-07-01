  require 'httparty'
  class GraphqlService
    def self.get_policies
      query = <<-GRAPHQL
        query { policies
          {
            policyId
            issueDate
            endCoverageDate
            insured {
              cpf
              name
            }
            vehicle {
              plate
              brand
              model
              year
            }
          }
        }
      GRAPHQL

      options = {
        body: {query: query}.to_json,
        headers: {"Content-Type" => "application/json"}
      }

      response = HTTParty.post("http://web-graphql-api:4000/graphql", options)
      JSON.parse(response.body)
    end

    def self.get_policy(policy_id)
      query = <<-GRAPHQL
        query PolicyResolver($policyId: Int!) {
          policy(policyId: $policyId) {
            policyId
            issueDate
            endCoverageDate
            insured {
              cpf
              name
            }
            vehicle {
              plate
              brand
              model
              year
            }
          }
        }
      GRAPHQL

      options = {
        body: {
          query: query,
          variables: { policyId: policy_id.to_i}
        }.to_json,
        headers: {"Content-Type" => "application/json"}
      }

      response = HTTParty.post("http://web-graphql-api:4000/graphql", options)
      JSON.parse(response.body)
    end

    def self.create_policy(params)
      policy_variables = set_variables(params)
      policy_attributes_input = set_attributes
      policy_arguments_input = set_arguments

      query = <<-GRAPHQL
        mutation createPolicy(#{policy_attributes_input}) {
          createPolicy ( input:#{policy_arguments_input} ) {
            status
          }
        }
      GRAPHQL

      options = {
        body: {
          query: query,
          variables: policy_variables
        }.to_json,
        headers: {"Content-Type" => "application/json"}
      }

      response = HTTParty.post("http://web-graphql-api:4000/graphql", options)
      JSON.parse(response.body)
    end

    def self.set_variables(params)
      {
        policyId: params[:policy_id].to_i,
        issueDate: params[:issue_date],
        endCoverageDate: params[:end_coverage_date],
        cpf: params[:cpf],
        name:params[:name],
        plate: params[:plate],
        brand: params[:brand],
        model: params[:model],
        year: params[:year]
      }
    end

    def self.set_attributes
      " $policyId: Int!
        $issueDate: ISO8601Date!
        $endCoverageDate: ISO8601Date!
        $name: String!
        $cpf: String!
        $plate: String!
        $brand: String!
        $model: String!
        $year: String!"
    end

    def self.set_arguments
      "{
        policy:{
          policyId: $policyId
          issueDate: $issueDate
          endCoverageDate: $endCoverageDate
          insured: {
            cpf: $cpf
            name: $name
          }
          vehicle: {
            plate: $plate
            brand: $brand
            model: $model
            year: $year
          }
        }
      }"
    end
  end
