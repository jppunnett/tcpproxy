# Tcpproxy

A very simple TCP/IP proxy server in Ruby.

tcpproxy was inspired by Alexander Demin's article:
[The Beauty of Concurrency in Go](http://pragprog.com/magazines/2012-06/the-beauty-of-concurrency-in-go).

tcpproxy is a very simple Ruby program that implements a TCP/IP proxy server.

This is not production software :-) I built it to explore a number of Ruby features:

* Threads
* Sockets
* Command Line Interfaces (CLI)

For CLI, I used David Copeland's excellent [Methadone](https://github.com/davetron5000/methadone) along with his wonderful book, [Build Awesome Command Line Applications in Ruby](http://pragprog.com/book/dccar/build-awesome-command-line-applications-in-ruby]).

## Usage

In the following example, tcpproxy listens on port 8888 for connections to google.com. At the end of the session, you'll find details about the conversation in a file named, tcpproxy_datetime.log, where datetime is the date and time of the conversation between client and server.

	ruby tcpproxy google.com:80
  
## Installation

Install it yourself as (TODO: Upload to RubyGems):

    $ gem install tcpproxy

## Contributing

This application is too simple to really make a contribution, but if you wish, please:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
