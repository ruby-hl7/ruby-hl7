# encoding: UTF-8
require 'spec_helper'

describe 'String hl7' do

  it 'encoding' do
    'a|||'.encode_hl7.should == 'a\\F\\\\F\\\\F\\'
    '&^\\|'.encode_hl7.should == '\\T\\\\S\\\\E\\\\F\\'
    "\\\n".encode_hl7.should == '\\E\\\\.br\\'
    "\r\n\r\n".encode_hl7.should == '\\.br\\\\.br\\'
  end

  it 'decoding' do
    "&^\\|\r\n".encode_hl7.decode_hl7.should == "&^\\|\r\n"
  end

end
