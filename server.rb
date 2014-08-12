require 'em-websocket'

myhost = "0.0.0.0"
myport = 5000

EM.run {
  puts "Listening on port #{myport}..."
  connections = [];
  EM::WebSocket.run(:host => myhost, :port => myport, :debug => false) do |ws|

    ws.onopen do |handshake|
      connections << ws
      puts "WebSocket opened:"
    end

    ws.onmessage { |msg|
      connections.each do |conn|
        conn.send "Pong: #{msg}"
      end
    }
    ws.onclose {
      puts "WebSocket closed"
    }
    ws.onerror { |e|
      puts "Error: #{e.message}"
    }
  end
}
