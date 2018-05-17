#!/usr/bin/env ruby

require 'json5'
require 'yaml'

app_config_file = ARGV[0]
data = File.read(app_config_file)

ext = File.extname(app_config_file)
if ext == '.json5'
  config = JSON5.parse(data)
elsif ext == '.yaml' || ext == '.yml'
  config = YAML.safe_load(data)
else
  raise "Invalid file format"
end

config['targets'].each do |target, values|
  puts "=========#{target}============"
  puts values['roles'].keys.join(',')
end

