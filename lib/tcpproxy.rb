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
      host, port = get_endpoint_parts
      begin
        ep = TCPSocket.new(host, port)
        
        # Copy data from client to endpoint
        cli_2_ep = Thread.new(io, ep) do |from, to|
          ProxyServer.copy_sock_data(from, to)
        end

        # Copy data from endpoint to client
        ep_2_cli = Thread.new(ep, io) do |from, to|
          ProxyServer.copy_sock_data(from, to)
        end
        
        cli_2_ep.join
        ep_2_cli.join
      rescue => ex
        debug("Failed to connect to #{@endpoint_name}.")
        debug("#{ex}")
      ensure
        begin
          ep.close if ep
        rescue
        end
      end
    end
    
    def ProxyServer.copy_sock_data(from_sock, to_sock)
      
    end

    private

    def get_endpoint_parts
      @endpoint_name.split(':', 2)
    end
  end
end
