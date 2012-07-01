require 'net/imap/response_parser/gmail'
require 'test/unit'

class Net::IMAP::ResponseParser::GmailTest < Test::Unit::TestCase
  def test_parses_gmail_fetch_attributes
    message = File.read(File.expand_path(File.join(__FILE__, '..', '..', '..', '..', 'fixtures', 'response.log')))

    parser = Net::IMAP::ResponseParser::Gmail.new
    result = parser.parse(message)

    assert_equal 123, result.data.attr['X-GM-MSGID']
    assert_equal 789, result.data.attr['X-GM-THRID']
    assert_equal ['Foo', 'Bar'], result.data.attr['X-GM-LABELS']
  end
end
