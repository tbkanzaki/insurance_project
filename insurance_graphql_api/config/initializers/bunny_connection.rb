#Be sure to restart your server when you modify this file.
require 'bunny'
conn = Bunny.new(host:  'rabbitmq',
                 port:  '5672',
                 vhost: '/',
                 user:  'guest',
                 pass:  'guest')

conn.start
channel = conn.create_channel

$conn = conn
$channel = channel
