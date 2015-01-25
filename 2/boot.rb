require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'sinatra/partial'

set :partial_template_engine, :erb

Dir[File.dirname(__FILE__) + '/app/*.rb'].each { |file| require file }