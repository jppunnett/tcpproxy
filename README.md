# Tcpproxy

tcpproxy spies on TCP connections. Use it to debug issues between a client and server.

## Installation

Add this line to your application's Gemfile:

    gem 'tcpproxy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tcpproxy

## Usage

In the following example, tcpproxy listens on port 8888 for connections to google.com. At the end of the session, you'll find details about the conversation in a file named, tcpproxy_datetime.log, where datetime is the date and time of the conversation between client and server.
	`ruby tcpproxy google.com:80`
  

## Contributing

This application is too simple to really make a contribution, but if you wish, please:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
