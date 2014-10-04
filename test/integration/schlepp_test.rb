require File.expand_path('../test_helper', __FILE__)

require 'pp'
require 'schlepp'

$LOAD_PATH.unshift(File.expand_path('../', __FILE__))


class Schlepp::IntegrationTest < Test::Unit::TestCase
  setup do
    @mock_writer = mock
    require 'mock/source'
    @mock_source = Mock::Source.new

    require 'mock/sink'
    @mock_sink = Mock::Sink.new
  end

  test '.schlepp' do
    table_object = Hydrogen::TableObject.new(@mock_model)

    res = Schlepp.schlepp(@mock_source, @mock_sink)

    refute res.nil?
  end
end

