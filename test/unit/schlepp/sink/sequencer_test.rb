require File.expand_path('../../../test_helper', __FILE__)

require 'schlepp/sink/sequencer'

class Schlepp::Sink::SequencerTest < Test::Unit::TestCase
  include TestHelper 
  setup do
    @mock_table_object = mock

    mock_chunker_klass = mock

    sequencer_klass = Class.new do
      include Schlepp::Sink::Sequencer
    end

    sequencer_klass.class_exec(mock_chunker_klass) do |mock_chunker_klass|
      define_method(:chunker) do
        mock_chunker_klass
      end
    end

    @mock_chunker = mock
    mock_chunker_klass.expects(:new).with(@mock_table_object).returns(@mock_chunker)

    @sequencer = sequencer_klass.new(@mock_table_object)

  end

  test '#write' do
    mock_loader = mock
    @mock_chunker.expects(:next).returns(mock_loader)

    data = "FOO|BAR|BAZ"
    
    mock_loader.expects(:written).returns(0)
    mock_loader.expects(:write).with(data)

    @sequencer.write([data])
  end

  test '#write with rollover' do
    data = "FOO|BAR|BAZ"

    state = states('loader').starts_as('start')

    mock_filled_loader = mock
    @mock_chunker.expects(:next).when(state.is('start')).returns(mock_filled_loader).then(state.is('filled'))
    mock_filled_loader.expects(:written).when(state.is('filled')).returns(Schlepp::Sink::Sequencer::DEFAULT_CHUNK_SIZE)
    mock_filled_loader.expects(:finalize).when(state.is('filled')).returns(Schlepp::Sink::Sequencer::DEFAULT_CHUNK_SIZE).then(state.is('finalized'))


    mock_empty_loader = mock
    @mock_chunker.expects(:next).when(state.is('finalized')).returns(mock_empty_loader).then(state.is('empty'))

    mock_empty_loader.expects(:write).when(state.is('empty')).with(data)

    @sequencer.write([data])
  end

  test '#finalize' do
    mock_filled_loader = mock

    @mock_chunker.expects(:next).returns(mock_filled_loader)

    mock_filled_loader.expects(:finalize)

    @sequencer.finalize
  end

end


