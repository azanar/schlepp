require File.expand_path('../../../test_helper', __FILE__)

require 'schlepp/table_object/chunker'

class Schlepp::TableObject::ChunkerTest < Test::Unit::TestCase
  include TestHelper 
  setup do
    @mock_model = mock

    @mock_model.expects(:name).returns("mock_model")

    @root_uri = URI('file:///tmp/')

    @chunker = Schlepp::TableObject::Chunker.new(@mock_model, @root_uri)

    @expected_parts = 5.times.map do |x|
      mock_obj = mock
      Hydrogen::TableObject.expects(:new).with(@mock_model, URI("file:///tmp/mock_model.#{x+1}")).returns(mock_obj)
      mock_obj
    end

  end

  test "#next" do
    @chunks = 5.times.map do
      @chunker.next
    end
  end
end


