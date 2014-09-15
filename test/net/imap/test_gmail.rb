require 'net/imap/gmail'
require 'test/unit'
require 'mocha/test_unit'

class Net::IMAP::GmailTest < Test::Unit::TestCase
  def test_is_imap
    assert_equal Net::IMAP, Net::IMAP::Gmail.superclass
  end

  def setup
    file = stub
    file.stubs(:write).returns(1)
    file.stubs(:gets).returns("* OK Ready.\r\n")
    TCPSocket.stubs(:open).returns(file)
    Thread.stubs(:start).returns(stub)
  end

  def test_initializes_imap
    imap = Net::IMAP::Gmail.new('imap.gmail.com', :port => 143, :ssl => false)
    assert_equal 'OK', imap.greeting.name
  end

  def test_patches_response_parser
    imap = Net::IMAP::Gmail.new('imap.gmail.com', :port => 143, :ssl => false)
    assert_equal Net::IMAP::ResponseParser::Gmail, imap.instance_variable_get(:@parser).class
  end
end
