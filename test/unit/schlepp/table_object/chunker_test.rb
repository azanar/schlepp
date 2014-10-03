require File.expand_path('../../../test_helper', __FILE__)

require 'schlepp/table_object/chunker'

class Schlepp::TableObject::ChunkerTest < Test::Unit::TestCase
  include TestHelper 
  setup do
    @mock_table_object = mock


    @chunker = Schlepp::TableObject::Chunker.new(@mock_table_object)

    @expected_parts = 5.times.map do |x|
      mock_part = mock
      Hydrogen::TableObject::Part.expects(:new).with(x+1, @mock_table_object).returns(mock_part)
      mock_part
    end

    @chunks = 5.times.map do
      @chunker.next
    end
  end

  test '#next to sequence' do
    mock_seq = mock
    Hydrogen::TableObject::Part::Sequence.expects(:new).with(@mock_table_object, @expected_parts).returns(mock_seq)

    seq = @chunker.sequence
    assert_equal seq, mock_seq
  end

  test '#next to parts' do
    parts = @chunker.parts

    assert_equal parts, @expected_parts
  end

end


