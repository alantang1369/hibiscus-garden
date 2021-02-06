ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

#set :environment, ENV['SINATRA_ENV'].to_sym
#database_config = {
#  :development => {
#    :adapter => "sqlite3",
#    :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
#  }
#}
#  
#set :database, database_config
ActiveRecord::Base.establish_connection(ENV['SINATRA_ENV'].to_sym)
require './app/controllers/application_controller'
require_all 'app'
