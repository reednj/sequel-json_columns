# Sequel::Plugins::JsonColumns

This plugin allows using json type columns in sequel, even in mysql where the database doesn't support them.

## Usage

Add the plugin to all models in the following way:

    class Sequel::Model
      plugin :json_columns
    end

Then flag individual columns as containing json data with the `json_column` class method.

    class User < Sequel::Model
      json_column :metadata

      # ...
    end

The content of these columns will be automatically parsed as json, so you can access the data as a hash, array etc

    user = User.first
    user.metadata # => {:name => 'dave', :age => 22}
    user.metadata[:age] += 1
    user.save_changess

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sequel-json_columns'
```

Or install it yourself as:

    $ gem install sequel-json_columns

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

