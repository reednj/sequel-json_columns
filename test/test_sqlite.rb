#!/usr/bin/env ruby

require 'sequel'
require 'json'
require 'yaml'

DB = Sequel.sqlite

class Sequel::Model
    plugin :json_columns
end

DB.create_table :items do
  primary_key :id
  String :name
  Float :price
end

class Item < Sequel::Model
	def self.random
		self.new do |item|
			item.name = 'item-' + (rand()*100).round.to_s
			item.price = (rand()*100).round(2)
		end
	end

	def to_s
		"#{name} (#{price})"
	end
end

10.times { Item.random.save }
puts Item.all.map{|i| i.to_s }.to_yaml
