# Be sure to restart your server when you modify this file.
require 'bunny'
require Rails.root.join("app", "workers", "create_policy_worker")

conn = Bunny.new(ENV['RABBITMQ_URL'])
conn.start

channel = conn.create_channel
queue = channel.queue('policy')

queue.subscribe(block: false) do |delivery_info, properties, payload|

    token = properties.headers['Authorization'].split(' ').last

    CreatePolicyWorker.execute(payload, token)
end
