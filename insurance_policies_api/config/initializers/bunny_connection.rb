# Be sure to restart your server when you modify this file.
require 'bunny'

conn = Bunny.new(ENV['RABBITMQ_URL'])
conn.start

channel = conn.create_channel
queue = channel.queue('policy')

$conn = conn
$channel = channel
$queue = queue
