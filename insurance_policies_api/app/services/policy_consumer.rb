
require 'bunny'
require_relative '../workers/create_policy_worker'
require_relative '../lib/rabbitmq_connection'

class PolicyConsumer
  include RabbitmqConnection

  def receive
    setup_conn

    begin
      puts ' [*] Waiting for messages. To exit press CTRL+C'
      @queue.subscribe(block: true) do |delivery_info, properties, payload|
        begin
          CreatePolicyWorker.execute(payload)
        rescue StandardError => e
          puts "Error processing message: #{e.message}"
        end
      end
    rescue StandardError => e
      puts " [x] An error occurred: #{e.message}"
    ensure
      @conn.close if @conn.open?
      puts ' [x] Connection closed'
    end
  end
end
