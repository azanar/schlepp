#!/usr/bin/env ruby
$LOAD_PATH.push(File.dirname(__FILE__) + '/../lib')

require 'hydrogen'
require 'schlepp'
require 'schlepp/sink/filter/chunker'
require 'schlepp/sink/filter/compressor'
require 'schlepp/sink/filter/formatter/csv'

require 'uri'
require 'pp'

require 'schlepp-sink-fs'

config = {
  :table_name => 'foo',
  :source => {:file => 'data.csv'},
  :columns => %w{foo bar baz}
}

model = Hydrogen::Model.new(config)

source = Schlepp::Source::CSV.new(File.new('data.csv','r'))

sink = Schlepp::Sink::Fs.new(model, URI('file:///tmp/foo/'),
                             :filters => [Schlepp::Sink::Filter::Formatter::Csv.new,
                                          Schlepp::Sink::Filter::Chunker.new(:chunk_size => 4000),
                                          Schlepp::Sink::Filter::Compressor.new])

res = Schlepp.schlepp(source, sink)


res.each do |r|
  puts r.url.path
end
