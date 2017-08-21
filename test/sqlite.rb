require 'sequel'

#
# This sets up an in memory sqlite database that can be used for running
# tests against.
#
DB = Sequel.sqlite

class Sequel::Model
	plugin :json_columns
end

DB.create_table :items do
	primary_key :id
	String :name
	Float :price
	String :info
end

class Item < Sequel::Model
	json_column :info

	def self.random
		self.new do |item|
			item.name = 'item-' + (rand()*100).round.to_s
			item.price = (rand()*100).round(2)
			item.info[:name] = item.name
			item.info[:date] = Time.now
			item.info[:color] = 'red'
		end
	end

	def to_s
		"#{name} (#{price})"
	end
end

# create some random data
10.times { Item.random.save }
