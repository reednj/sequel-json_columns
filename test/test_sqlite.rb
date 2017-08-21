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


end



