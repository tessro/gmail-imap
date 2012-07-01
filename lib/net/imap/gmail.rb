require 'net/imap'
require 'net/imap/response_parser/gmail'

class Net::IMAP::Gmail < Net::IMAP
  def initialize(*args)
    super(*args)
    instance_variable_set(:@parser, Net::IMAP::ResponseParser::Gmail.new)
  end
end
