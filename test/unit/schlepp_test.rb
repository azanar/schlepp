require File.expand_path('../test_helper', __FILE__)

require 'schlepp'

class SchleppTest < Test::Unit::TestCase
  include TestHelper 
  test '.schlepp' do
    mock_source = mock

    mock_source.expects(:each).multiple_yields("foo", "bar", "baz")

    mock_sink = mock

    mock_sink.expects(:write).with("foo")
    mock_sink.expects(:write).with("bar")
    mock_sink.expects(:write).with("baz")

    mock_parts = mock
    mock_sink.expects(:finalize).returns(mock_parts)

    parts = Schlepp.schlepp(mock_source, mock_sink)

    assert_equal parts, mock_parts
  end
end
