require "tcpproxy/version"
require "methadone"
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
      ep = TCPSocket.new(host, port)
      
      begin
        ConvoLogger.new do |l|
        
          cli_peeraddr = io.peeraddr[3] + ":" + io.peeraddr[1].to_s
          ep_peeraddr = ep.peeraddr[3] + ":" + ep.peeraddr[1].to_s

          debug("Convo starting: #{cli_peeraddr} <--> #{ep_peeraddr}")
          l.log("Convo starting: #{cli_peeraddr} <--> #{ep_peeraddr}")
          
          # Copy data from client to endpoint
          cli_2_ep = Thread.new(io, ep, l) do |from, to, logger|
            copy_sock_data(from, to, l)
          end

          # Copy data from endpoint to client
          ep_2_cli = Thread.new(ep, io, l) do |from, to, logger|
            copy_sock_data(from, to, l)
          end
          
          cli_2_ep.join
          ep_2_cli.join
          
          debug("Convo ending: #{cli_peeraddr} <--> #{ep_peeraddr}")
          l.log("Convo ending: #{cli_peeraddr} <--> #{ep_peeraddr}")
          
        end
      rescue => ex
        debug("#{ex}")
      ensure
        begin
          ep.close if ep
        rescue
        end
      end
    end
    
    private

    def copy_sock_data(from_sock, to_sock, logger)
      from_addr = from_sock.peeraddr[3] + ":" + from_sock.peeraddr[1].to_s
      to_addr = to_sock.peeraddr[3] + ":" + to_sock.peeraddr[1].to_s
      
      done = false
      while !done
        begin
          buf = from_sock.readpartial(1024)
        rescue EOFError
          done = true
        end
        to_sock << buf if buf
        logger.log("#{from_addr} --> #{to_addr} (#{buf.length}): #{buf}") if buf
      end
    end

    def get_endpoint_parts
      @endpoint_name.split(':', 2)
    end
  end # class ProxyServer
  
  ##
  # This class represents a threadsafe file appender. We use it to log
  # information about a TCP/IP conversation.
  class ConvoLogger
  
    def initialize
      raise "Must supply a block" unless block_given?
      @the_log_file = File.new("convo.out.txt", "w")
      @the_log_file_mtx = Mutex.new
      begin
        yield self
      ensure
        @the_log_file.close if @the_log_file
      end      
    end
    
    def log(the_text)
      @the_log_file_mtx.synchronize do
        @the_log_file.puts the_text
      end
    end
  end # class ConvoLogger
  
end
