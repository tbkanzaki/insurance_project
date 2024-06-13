
require 'bunny'
require_relative '../workers/create_policy_worker'
class PolicyConsumer
  def self.receive
    begin
      puts ' [*] Waiting for messages. To exit press CTRL+C'
      $queue.subscribe(block: true) do |delivery_info, properties, payload|
        begin
          CreatePolicyWorker.execute(payload)
          puts " Processed message: #{payload} "
        rescue StandardError => e
          puts "Error processing message: #{e.message}"
        end
      end
    rescue Interrupt => _
      puts " [x] The connection has been interrupted, shutting down..."
      @conn.close if @conn.open?
      puts ' [x] Connection closed'
    rescue StandardError => e
      puts " [x] An error occurred: #{e.message}"
      @conn.close if @conn.open?
      puts ' [x] Connection closed'
    end
  end
end
