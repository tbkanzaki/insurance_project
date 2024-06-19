module Types
  class PolicyArgumentsType < Types::BaseInputObject
    description "Arguments for creating a car insurance policy"
    argument :policy_id, Integer, required: true
    argument :issue_date, GraphQL::Types::ISO8601Date, required: true
    argument :end_coverage_date, GraphQL::Types::ISO8601Date, required: true
    argument :insured, Types::InsuredArgumentsType, required: true
    argument :vehicle, Types::VehicleArgumentsType, required: true
  end
end
