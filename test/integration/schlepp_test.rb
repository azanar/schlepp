require File.expand_path('../test_helper', __FILE__)

require 'pp'
require 'schlepp'

$LOAD_PATH.unshift(File.expand_path('../', __FILE__))


class Schlepp::IntegrationTest < Test::Unit::TestCase
  setup do
    @model= Hydrogen::Model.new({
      :table_name => "foo",
      :key => "key",
      :columns => ["baz", "blarg"]
    })

    @verifier = mock

    @mock_writer = mock
    require 'mock/source'
    @mock_source = Mock::Source.new

    require 'mock/sink'
    @mock_sink = Mock::Sink.new(@model, @verifier)
  end

  test '.schlepp' do
    1.upto(100).each do |x|
      @verifier.expects(:write).with(x.to_s)
    end

    @verifier.expects(:finalize)

    res = Schlepp.schlepp(@mock_source, @mock_sink)

    object = res.first

    puts res.inspect

    assert_equal object.url, URI("http://www.example.com/.1")
    assert_equal object.name, "foo"
  end
end

