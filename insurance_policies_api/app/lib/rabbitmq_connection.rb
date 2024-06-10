module RabbitmqConnection
  def setup_conn
    @conn = Bunny.new(host: 'rabbitmq', port: 5672, user: 'guest', password: 'guest')
    @conn.start

    @channel = @conn.create_channel
    @queue = @channel.queue('policy')
  end
end
