# frozen_string_literal: true

#  SegmentFields
#  class HL7::Message::Segment::NK1 < HL7::Message::Segment
#    weight 100 # segments are sorted ascendingly
#    add_field :something_you_want       # assumes :idx=>1
#    add_field :something_else, :idx=>6  # :idx=>6 and field count=6
module HL7::Message::SegmentFields
  def self.included(base)
    base.extend(ClassMethods)
  end

  @elements = []

  module ClassMethods
    # define a field alias
    # * name is the alias itself (required)
    # * options is a hash of parameters
    #   * :id is the field number to reference (optional, auto-increments from 1
    #      by default)
    #   * :blk is a validation proc (optional, overrides the second argument)
    # * blk is an optional validation/convertion proc which MUST
    #   take a parameter and always return a value for the field (it will be
    #    used on read/write calls)
    def add_field(name, options = {}, &blk)
      options = { :idx => -1, :blk => blk }.merge!(options)
      name ||= :id
      namesym = name.to_sym
      @field_cnt ||= 1
      if options[:idx] == -1
        options[:idx] = @field_cnt # provide default auto-incrementing
      end
      @field_cnt = options[:idx].to_i + 1

      singleton.module_eval do
        @fields ||= {}
        @fields[namesym] = options
      end

      class_eval <<-END, __FILE__, __LINE__ + 1
        def #{name}(val=nil)
          unless val
            read_field( :#{namesym} )
          else
            write_field( :#{namesym}, val )
            val # this matches existing n= method functionality
          end
        end

        def #{name}=(value)
          write_field( :#{namesym}, value )
        end
      END
    end

    def fields # :nodoc:
      singleton.module_eval do
        (@fields ||= [])
      end
    end

    def alias_field(new_field_name, old_field_name)
      class_eval <<-END, __FILE__, __LINE__ + 1
        def #{new_field_name}(val=nil)
          raise HL7::InvalidDataError.new unless self.class.fields[:#{old_field_name}]
          unless val
            read_field( :#{old_field_name} )
          else
            write_field( :#{old_field_name}, val )
            val # this matches existing n= method functionality
          end
        end

        def #{new_field_name}=(value)
          write_field( :#{old_field_name}, value )
        end
      END
    end
  end

  def field_info(name) # :nodoc:
    field_blk = nil
    idx = name # assume we've gotten a integer
    unless name.is_a?(Integer)
      fld_info = self.class.fields[name]
      idx = fld_info[:idx].to_i
      field_blk = fld_info[:blk]
    end

    [idx, field_blk]
  end

  def [](index)
    @elements[index]
  end

  def []=(index, value)
    @elements[index] = value.to_s
  end

  def read_field(name) # :nodoc:
    idx, field_blk = field_info(name)
    return nil unless idx
    return nil if idx >= @elements.length

    ret = @elements[idx]
    ret = ret.first if ret.is_a?(Array) && ret.length == 1
    ret = field_blk.call(ret) if field_blk
    ret
  end

  def write_field(name, value) # :nodoc:
    idx, field_blk = field_info(name)
    return nil unless idx

    if idx >= @elements.length
      # make some space for the incoming field, missing items are assumed to
      # be empty, so this is valid per the spec -mg
      missing = ("," * (idx - @elements.length)).split(",", -1)
      @elements += missing
    end

    value = value.first if value.is_a?(Array) && value.length == 1
    value = field_blk.call(value) if field_blk
    @elements[idx] = value.to_s
  end
end
