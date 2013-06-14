require "tcpproxy/version"
require "gserver"
require "socket"

module Tcpproxy
  # Default port to listen on for incoming connections.
  DEFAULT_LISTEN_PORT = 10001
  class ProxyServer < GServer
    
    def initialize(listen_port, endpoint_name)
      super(listen_port)
      @listen_port = listen_port
      @endpoint_name = endpoint_name
    end
    
    def serve(io)
      #  Connect to the endpoint
      ep = TCPSocket.open(get_hostname(@endpoint_name), get_port(@endpoint_name))
      
      # Start two threads:
      #   One that reads data from the client and passes it to the endpoint
      #   One that reads data from the endpoint and passes it to the client
      
      ep.close
      # Stop when there's no more data to exchange.
      
      stop
    end
        
  end
end
