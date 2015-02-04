require 'bundler/setup'
Bundler.require(:default)

require 'rubygems'
require 'sinatra'

require 'sinatra/reloader'

set :partial_template_engine, :erb

require './models'

get "/" do

  authors = Author.where('1')

  partial(:"authors", :locals => {authors: authors})

end

get "/authors/:user_name" do |user_name|

  author = Author.find_by user_name: user_name.to_s

  partial(:"author_videos", :locals => {author: author})

end