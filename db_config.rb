
require 'pg'
require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'homechekr'
}

ActiveRecord::Base.establish_connection(options)