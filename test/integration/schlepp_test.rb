require File.expand_path('../test_helper', __FILE__)

require 'pp'
require 'schlepp'

class Schlepp::IntegrationTest < Test::Unit::TestCase
  setup do
    @mock_writer = mock
  end

  test '#loader' do
    table_object = Hydrogen::TableObject.new(@mock_model)

    loader = Schlepp::Sink::Loader.new(@mock_writer)

    @mock_writer.expects(:write)
    loader.write(["FOO|BAR|BAZ"] * 10)

    loader.finalize
  end
end

