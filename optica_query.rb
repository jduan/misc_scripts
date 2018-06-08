#!/usr/bin/env ruby

require 'json'
# filepath to the output of querying optica for all hosts
optica_data = ARGV[0]
File.open(optica_data) do |fd|
  j = JSON.load(fd)
  nodes = j['nodes']
  nodes.each do |key, value|
    begin
    recipes = value['recipes']
    chef_role = value['role']
    hostname = value['hostname']
    ruby_versions = recipes.select do |recipe|
      recipe =~ /^ruby/
    end
    puts "#{hostname},#{chef_role},#{ruby_versions.join(' ')}"
    rescue => e
      STDERR.puts "error processing node: #{value}"
      STDERR.puts e
    end
  end
end
