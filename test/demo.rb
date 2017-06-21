#!/usr/bin/env ruby

require 'sequel'
require 'json'
require 'yaml'

DB = Sequel::Database.connect({
    :adapter => 'mysql2',
    :user => 'linkuser',
    :password => '',
    :host => '127.0.0.1',
    :database => 'asteroids'
})

class Sequel::Model
    plugin :json_columns
end

class ActionLog < Sequel::Model(:action_log)
    json_column :extended_data_json

    def before_save
        super
        puts 'hello'
    end
end

class App
    def main
        a = ActionLog.first
        a.extended_data_json[:hello] = rand.to_s
        a.extended_data_json[:age] = (a.extended_data_json[:age] || 0) + 1
        a.save_changes

        puts a.values.to_yaml
    end
end

App.new.main
