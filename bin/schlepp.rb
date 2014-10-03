#!/usr/bin/env ruby
$LOAD_PATH.push(File.dirname(__FILE__) + '/../lib')

require 'hydrogen'
require 'schlepp'

require 'schlepp/sinks/fs'

config = {
  :table_name => 'foo',
  :source => {:file => 'data.csv'},
  :columns => %w{foo bar baz}
}

model = Hydrogen::Model.new(config)

source = Schlepp::Source::CSV.new(File.new('data.csv','r'))

l = Schlepp::Sink::Fs::Sequencer.new(model, :chunk_size => 40000)

res = Schlepp.schlepp(source, l)

puts res.inspect

res.each do |r|
  puts r.url.scheme
end
