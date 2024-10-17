# frozen_string_literal: true

# $Id$
# Ruby-HL7 Proxy Server Example
require "rubygems"
require "ruby-hl7"
require "socket"

PORT = 2402
target_ip = "127.0.0.1"
target_port = 5900

srv = TCPServer.new(PORT)
puts format("proxy_server listening on port: %i", PORT)
puts format("proxying for: %s:%i", target_ip, target_port)
loop do
  sok = srv.accept
  Thread.new(sok) do |my_socket|
    my_socket.readlines
    msg = HL7::Message.new(raw_input)
    puts format("forwarding message:\n%s", msg.to_s)
    soc = TCPSocket.open(target_ip, target_port)
    soc.write msg.to_mllp
    soc.close
  end
end
