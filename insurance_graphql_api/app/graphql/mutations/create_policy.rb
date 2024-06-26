require 'bunny'
module Mutations
  class CreatePolicy < Mutations::BaseMutation
    argument :policy, Types::PolicyArgumentsType

    field :status, String, null: false

    def resolve(policy:)
        queue = $channel.queue('policy')
        queue.publish(policy.to_json)
        {
          status: "OK"
        }
      rescue StandardError => e
        raise GraphQL::ExecutionError.new(e.message)
      end
    end
  end
