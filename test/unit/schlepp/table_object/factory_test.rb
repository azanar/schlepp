require File.expand_path('../../../test_helper', __FILE__)

require 'schlepp/sink/table_object/factory'

class Schlepp::Sink::TableObject::FactoryTest < Test::Unit::TestCase
  include TestHelper 
  setup do
    @mock_factory = mock

    url = URI("file:///tmp/example")

    @mock_factory.expects(:url).returns(url)

    mock_model = mock

    @mock_factory.expects(:model).returns(mock_model)


    @mock_filters = 5.times.map do |wf|
      mock_filter = mock
      mock_filter.expects(:rotate)

      mock_filter
    end

    @mock_filters.each_with_index do |f, idx|
      f.expects(:extension).returns(idx)
    end

    @mock_table_object = mock
    expected_url = URI("file:///tmp/example.0.1.2.3.4")
    Hydrogen::TableObject.expects(:new).with(mock_model, expected_url).returns(@mock_table_object)

    @factory = Schlepp::Sink::TableObject::Factory.new(@mock_factory, @mock_filters)
  end
  test "#new" do
    res = @factory.new

    assert_equal res, @mock_table_object
  end

  test "#writer" do

    mock_table_object_writer_factory = mock
    Schlepp::Sink::TableObject::Writer::Factory.expects(:new).with(@mock_factory, @mock_filters, @mock_table_object).returns(mock_table_object_writer_factory)
    
    mock_writer = mock
    mock_table_object_writer_factory.expects(:new).returns(mock_writer)


    res = @factory.writer

    assert_equal res, mock_writer
  end
end
