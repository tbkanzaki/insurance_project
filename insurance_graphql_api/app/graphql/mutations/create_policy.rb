require 'bunny'
module Mutations
  class CreatePolicy < Mutations::BaseMutation
    argument :policy, Types::PolicyArgumentsType, required: true

    field :status, String, null: false

    def resolve(policy:)
        queue = $channel.queue('policy')
        headers = {Authorization: "Bearer #{context[:token]}"}

        queue.publish(policy.to_json, { headers: headers })
        {
          status: "OK"
        }
      rescue StandardError => e
        raise GraphQL::ExecutionError.new(e.message)
      end
    end
  end
