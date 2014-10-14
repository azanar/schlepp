require File.expand_path('../../../test_helper', __FILE__)

require 'schlepp/sink/table_object/carosel'

class Schlepp::Sink::TableObject::CaroselTest < Test::Unit::TestCase
  include TestHelper 

  setup do
    @mock_factory = mock

    @mock_table_object = mock

    @mock_filters = 5.times.map do |wf|
      mock
    end

    @mock_table_object_factory = mock
    Schlepp::Sink::TableObject::Factory.expects(:new).with(@mock_factory, @mock_filters).returns(@mock_table_object_factory)

    @mock_table_object_factory.expects(:new).returns(@mock_table_object)

    mock_table_object_writer_factory = mock
    Schlepp::Sink::TableObject::Writer::Factory.expects(:new).with(@mock_factory, @mock_filters, @mock_table_object).returns(mock_table_object_writer_factory)

    @mock_writer = mock
    mock_table_object_writer_factory.expects(:new).returns(@mock_writer)

    @carosel = Schlepp::Sink::TableObject::Carosel.new(@mock_factory, @mock_filters)
  end

  test "#write" do
    mock_data = mock

    @mock_filters.each do |f|
      f.expects(:should_rotate?).returns(false)
    end

    @mock_writer.expects(:write).with(mock_data)

    @carosel.write(mock_data)
  end

  test "#write with rotation" do
    mock_data = mock

    rotation_state = states('rotation').starts_as('unrotated')

    @mock_filters.first.expects(:should_rotate?).
                        when(rotation_state.is('unrotated')).
                        then(rotation_state.is('rotated')).
                        returns(true)


    @mock_filters.each do |f|
      f.expects(:should_rotate?).when(rotation_state.is('rotated')).returns(false)
    end

    @mock_writer.expects(:finalize)
    
    mock_second_table_object = mock
    @mock_table_object_factory.expects(:new).returns(mock_second_table_object)

    mock_table_object_writer_factory = mock
    Schlepp::Sink::TableObject::Writer::Factory.expects(:new).with(@mock_factory, @mock_filters, mock_second_table_object).returns(mock_table_object_writer_factory)

    mock_replacement_writer = mock
    mock_table_object_writer_factory.expects(:new).returns(mock_replacement_writer)

    mock_replacement_writer.expects(:write).with(mock_data)

    @carosel.write(mock_data)
  end
  test "#write with endless rotation should fail" do
    mock_data = mock

    rotation_state = states('rotation').starts_as('unrotated')

    @mock_filters.first.expects(:should_rotate?).
                        when(rotation_state.is('unrotated')).
                        then(rotation_state.is('rotated')).
                        returns(true)

    @mock_filters.first.expects(:should_rotate?).
                        when(rotation_state.is('rotated')).
                        returns(true)


    @mock_writer.expects(:finalize)
    
    mock_second_table_object = mock
    @mock_table_object_factory.expects(:new).returns(mock_second_table_object)

    mock_table_object_writer_factory = mock
    Schlepp::Sink::TableObject::Writer::Factory.expects(:new).with(@mock_factory, @mock_filters, mock_second_table_object).returns(mock_table_object_writer_factory)

    mock_replacement_writer = mock
    mock_table_object_writer_factory.expects(:new).returns(mock_replacement_writer)

    assert_raises do
      @carosel.write(mock_data)
    end
  end
end

