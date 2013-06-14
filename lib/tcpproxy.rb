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
      ep = TCPSocket.open(get_endpoint_hostname(), get_endpoint_port())
      
      # Start two threads:
      #   One that reads data from the client and passes it to the endpoint
      #   One that reads data from the endpoint and passes it to the client
      
      ep.close
      # Stop when there's no more data to exchange.
      
      stop
    end
    
    private
    
    def get_endpoint_hostname
      @endpoint_name.split(':', 1)[0]
    end
        
    def get_endpoint_port
      @endpoint_name.split(':', 2)[1]
    end
  end
end
