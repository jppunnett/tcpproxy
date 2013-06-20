require "tcpproxy/version"
require 'methadone'
require "gserver"
require "socket"

module Tcpproxy
  # Default port to listen on for incoming connections.
  DEFAULT_LISTEN_PORT = 10001
  class ProxyServer < GServer
    
    include Methadone::CLILogging
    
    def initialize(listen_port, endpoint_name)
      super(listen_port)
      @listen_port = listen_port
      @endpoint_name = endpoint_name
    end
    
    def serve(io)
      
      host = get_endpoint_hostname
      port = get_endpoint_port
      debug("Connecting to Host: #{host}, Port: #{port}")
#      ep_sock = TCPSocket.open(host, port)
#      ep_sock.close
#      
      debug("Stopping.")
      stop
      debug("Stopped.")
    end
    
    private
    
    def get_endpoint_hostname
      @endpoint_name.split(':', 2)[0]
    end
        
    def get_endpoint_port
      @endpoint_name.split(':', 2)[1]
    end
  end
end
