module Types
  class PolicyType < Types::BaseObject
    description "Vehicle insurance policy data"
    field :policy_id, Integer, null: false
    field :issue_date, GraphQL::Types::ISO8601Date, null: false
    field :end_coverage_date, GraphQL::Types::ISO8601Date, null: false
    field :insured, Types::InsuredType, null: false
    field :vehicle, Types::VehicleType, null: false
    field :payment_id, String, null: false
    field :payment_link, String, null: false
    field :payment_status, String, null: false
  end
end
