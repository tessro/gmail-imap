class Net::IMAP::ResponseParser::Gmail < Net::IMAP::ResponseParser
  def msg_att(n = nil)
    match(T_LPAR)
    attr = {}
    while true
      token = lookahead
      case token.symbol
      when T_RPAR
        shift_token
        break
      when T_SPACE
        shift_token
        next
      end
      case token.value
      when /\A(?:ENVELOPE)\z/ni
        name, val = envelope_data
      when /\A(?:FLAGS)\z/ni
        name, val = flags_data
      when /\A(?:INTERNALDATE)\z/ni
        name, val = internaldate_data
      when /\A(?:RFC822(?:\.HEADER|\.TEXT)?)\z/ni
        name, val = rfc822_text
      when /\A(?:RFC822\.SIZE)\z/ni
        name, val = rfc822_size
      when /\A(?:BODY(?:STRUCTURE)?)\z/ni
        name, val = body_data
      when /\A(?:UID)\z/ni
        name, val = uid_data
      when /\A(?:X-GM-LABELS)\z/ni
        name, val = label_data
      when /\A(?:X-GM-MSGID)\z/ni
        name, val = uid_data
      when /\A(?:X-GM-THRID)\z/ni
        name, val = uid_data
      else
        if n # Ruby >= 2.0.0
          parse_error("unknown attribute `%s' for {%d}", token.value, n)
        else # Ruby <= 1.9.3
          parse_error("unknown attribute `%s'", token.value)
        end
      end
      attr[name] = val
    end
    return attr
  end

  def label_data
    token = match(T_ATOM)
    name = token.value.upcase
    match(T_SPACE)
    return name, astring_list
  end

  def astring_list
    result = []
    match(T_LPAR)
    while true
      token = lookahead
      case token.symbol
      when T_RPAR
        shift_token
        break
      when T_SPACE
        shift_token
      end
      result.push(astring)
    end
    return result
  end
end
