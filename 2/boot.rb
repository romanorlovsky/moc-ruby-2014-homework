require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'active_support'
require 'youtube_it'
require 'json'
require 'json/add/core'

set :partial_template_engine, :erb

Dir[File.dirname(__FILE__) + '/app/*.rb'].each { |file| require file }