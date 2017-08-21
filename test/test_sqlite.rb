#!/usr/bin/env ruby

require 'rubygems'
require 'test/unit'

require 'json'
require 'yaml'

require_relative './sqlite'


class JsonColumnTests < Test::Unit::TestCase
	def test_read_json_column
		a = Item[2]
		assert_not_nil a
		assert_not_nil a.info
		assert a.info.is_a? Hash
		assert_equal a.info[:color], "red"
	end

	def test_save_json_column
		a = Item.random.save
		a.name = 'hello m8'
		a.info[:color] = 'blue'
		a.save

		# get the same item again, and make sure the json changes have
		# persisted
		b = Item[a.id]
		assert_equal a.id, b.id
		assert_equal a.name, b.name
		assert_equal a.info[:color], b.info[:color]
	end

	# need to make sure that if the json column is the only thing changed
	# this it gets serialized properly still
	def test_detect_changes
		a = Item.random.save
		a.info[:color] = '#fd4'
		a.save_changes

		# get the same item again, and make sure the json changes have
		# persisted
		b = Item[a.id]
		assert_equal a.id, b.id
		assert_equal a.info[:color], b.info[:color]
	end

	# there is a bug where if the metadata has been accessed, and is then
	# changed elsewhere afterwards, a refresh will not pick up the change, 
	# because the cached object is not cleared properly
	#
	# to test this, we get an item, access the json_column, then modify the
	# json_column in a different object and refresh the original. Without an
	# overriden `refresh` they will not match
	def test_refresh_object
		# the json_column is lazy loaded, so it is important that we access it
		# at the start, otherwise this test wil not replicate the bug
		a = Item.last
		assert_not_nil a.info

		b = Item[a.id]
		b.name = 'hello'
		b.info[:color] = 'yellow'

		# save the changes to b and refresh a. The object should
		# now be equal
		b.save
		a.refresh

		assert_equal a.name, b.name
		assert_equal a.info[:color], b.info[:color]

	end
end



