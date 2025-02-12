# frozen_string_literal: true

# Class for grouping the messages delimiter
class HL7::Message::Delimiter
  attr_accessor :item, :element, :segment

  def initialize(element_delim, item_delim, segment_delim)
    @element = element_delim
    @item = item_delim
    @segment = segment_delim
  end
end
