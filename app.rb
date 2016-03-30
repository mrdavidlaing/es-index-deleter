require 'json'
require 'time'
require 'rufus-scheduler'

es_master = ENV['ES_MASTER_URL'] || 'http://localhost:9200'
deleted_index_pattern = ENV['DELETED_INDEX_PATTERN'] || 'logstash-unparsed-*'
delete_every = ENV['DELETE_EVERY'].to_i || 10

scheduler = Rufus::Scheduler.new

scheduler.every "#{delete_every}m", :first_in => '1s' do
  puts "Deleting index"
  cmd = "curl -XDELETE #{es_master}/#{deleted_index_pattern}"
  puts cmd
  puts `#{cmd}`
  $stdout.flush
end

scheduler.join
