require File.expand_path('../../../test_helper', __FILE__)

require 'schlepp/sink/loader'
require 'schlepp/sink/data_object'

class Schlepp::Sink::LoaderTest < Test::Unit::TestCase
  include TestHelper 
  setup do
    @mock_table_object = mock

    @mock_data_object = mock
    Schlepp::Sink::DataObject.expects(:new).with(@mock_table_object).returns(@mock_data_object)

    @s3_loader = Schlepp::Sink::Loader.new(@mock_table_object)
  end

  test '#write' do
    @mock_data_object.expects(:write).with("FOO|BAR|BAZ")
    @s3_loader.write(["FOO|BAR|BAZ"])
  end

  test '#finalize' do
    @mock_data_object.expects(:finalize)

    @s3_loader.finalize
  end

end

