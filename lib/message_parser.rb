module HL7::MessageBatchParser
  def parse_batch(batch) # :yields: message
    raise HL7::ParseError, 'badly_formed_batch_message' unless
      batch.hl7_batch?

    batch = clean_batch_for_jruby batch

    raise HL7::ParseError, 'empty_batch_message' unless
      match = /\rMSH/.match(batch)

    match.post_match.split(/\rMSH/).each do |_msg|
      if md = /\rBTS/.match(_msg)
        # TODO: Validate the message count in the BTS segment
        # should == index + 1
        _msg = md.pre_match
      end

      yield 'MSH' + _msg
    end
  end

  # parse a String or Enumerable object into an HL7::Message if possible
  # * returns a new HL7::Message if successful
  def parse( inobj )
    HL7::Message.new do |msg|
      msg.parse( inobj )
    end
  end

  # JRuby seems to change our literal \r characters in sample
  # messages (from here documents) into newlines.  We make a copy
  # here, reverting to carriage returns.  The input is unchanged.
  #
  # This does not occur when posts are received with CR
  # characters, only in sample messages from here documents.  The
  # expensive copy is only incurred when the batch message has a
  # newline character in it.
  private

  def clean_batch_for_jruby(batch)
    batch.gsub("\n", "\r") if batch.include?("\n")
  end
end

# Provides basic methods to parse_string, element and item delimeter parser
class HL7::MessageParser
  attr_reader :delimiter

  def self.split_by_delimiter(element, delimiter)
    element.split( delimiter, -1 )
  end

  def initialize(delimiter)
    @delimiter = delimiter
  end

  # parse the provided String or Enumerable object into this message
  def parse_string( instr )
    post_mllp = instr
    if /\x0b((:?.|\r|\n)+)\x1c\r/.match( instr )
      post_mllp = $1 #strip the mllp bytes
    end
    HL7::MessageParser.split_by_delimiter(post_mllp, @delimiter.segment)
  end

  # Get the element delimiter from an MSH segment
  def parse_element_delim(str)
    (str && str.kind_of?(String)) ? str.slice(3,1) : "|"
  end

  # Get the item delimiter from an MSH segment
  def parse_item_delim(str)
    (str && str.kind_of?(String)) ? str.slice(4,1) : "^"
  end

  # Get the repetition delimiter from an MSH segment
  def parse_repetition_delim(str)
    (str && str.kind_of?(String)) ? str.slice(5,1) : "~"
  end
end
