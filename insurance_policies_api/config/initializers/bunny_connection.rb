# Be sure to restart your server when you modify this file.
require 'bunny'

conn = Bunny.new(ENV['RABBITMQ_URL'])
conn.start

channel = conn.create_channel
queue_policy_create = channel.queue('policy')
queue_policy_payment = channel.queue('payment')

queue_policy_create.subscribe(block: false) do |delivery_info, properties, payload|
  token = properties.headers['Authorization'].split(' ').last

  CreatePolicyWorker.execute(payload, token)
end

queue_policy_payment.subscribe(block: false) do |delivery_info, properties, payload|
  UpdatePolicyWorker.execute(payload)
end
