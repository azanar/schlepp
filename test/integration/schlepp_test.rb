require File.expand_path('../test_helper', __FILE__)

require 'schlepp'
require 'schlepp/sinks/aws/s3'

class Schlepp::IntegrationTest < Test::Unit::TestCase
  setup do
    @stub_s3_bucket = stub
    Schlepp::Sink::AWS::S3.stubs(:bucket).returns(@stub_s3_bucket)

    @stub_s3_objects = stub
    @stub_s3_bucket.stubs(:objects).returns(@stub_s3_objects)

    @mock_s3_object = mock
    @stub_s3_objects.stubs(:[]).returns(@mock_s3_object)

    @mock_model = mock
    @mock_model.expects(:name).at_least_once.returns("mock_models")
  end

  test 'stuff' do
    table_object = Hydrogen::TableObject.new(@mock_model)

    s3_table_object = Schlepp::Sink::AWS::S3::TableObject.new(table_object)

    writer = Schlepp::Sink::AWS::S3::TableObject::Writer.new(table_object)

    loader = Schlepp::Sink::Loader.new(writer)

    @mock_s3_object.expects(:write)
    loader.write(["FOO|BAR|BAZ"] * 10)

    loader.finalize
  end
end

