require File.expand_path('../test_helper', __FILE__)

require 'pp'
require 'schlepp'

class Schlepp::IntegrationTest < Test::Unit::TestCase
  setup do
    @mock_writer = mock

    #@mock_model = mock
    #@mock_model.expects(:name).at_least_once.returns("mock_models")
  end

  test 'stuff' do
    table_object = Hydrogen::TableObject.new(@mock_model)

    loader = Schlepp::Sink::Loader.new(@mock_writer)

    @mock_writer.expects(:write)
    loader.write(["FOO|BAR|BAZ"] * 10)

    loader.finalize
  end
end

