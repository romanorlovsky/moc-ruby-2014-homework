require 'bundler/setup'
Bundler.require(:default)

require 'rubygems'
require 'sinatra'

require 'sinatra/reloader'

register Padrino::Helpers

enable :protect_from_csrf

set :partial_template_engine, :erb

require './models'

get "/" do
  redirect to('/authors')
end

get "/authors" do
  authors = Author.all
  erb :authors, locals: {authors: authors}, layout: "layout"
end

get "/authors/:user_name/videos" do |user_name|
  author = Author.find_by user_name: user_name.to_s
  erb :author_videos, locals: {author: author}, layout: "layout"
end

get "/authors/:user_name/articles" do |user_name|
  author = Author.find_by user_name: user_name.to_s
  erb :author_articles, locals: {author: author}, layout: "layout"
end

get "/article/:slug" do |slug|
  article = Article.find_by slug: slug.to_s
  erb :article, locals: {article: article}, layout: "layout"
end

get "/video/:slug" do |slug|
  video = Video.find_by slug: slug.to_s
  erb :video, locals: {video: video}, layout: "layout"
end


get "/authors/:id/edit" do |id|
  author = Author.find(id)
  erb :author_edit, locals: {author: author}, layout: "layout"
end

put "/authors/:id" do |id|
  author = Author.find(id)
  author.update_attributes(params[:author])
  if author.save
    redirect to("/authors")
  else
    erb :author_edit, locals: {author: author}, layout: "layout"
  end
end

delete "/authors/:id" do |id|
  author = Author.find(id)
  author.destroy
  redirect to("/authors")
end


get "/videos/new" do
  video = Video.new
  authors = Author.all
  erb :video_new, locals: {video: video, authors: authors}, layout: "layout"
end

get "/videos/:id/edit" do |id|
  video = Video.find(id)
  authors = Author.all
  erb :video_edit, locals: {video: video, authors: authors}, layout: "layout"
end

put "/videos/:id" do |id|
  video = Video.find(id)
  video.update_attributes(params[:video])
  if video.save
    redirect to("/video/#{video.slug}")
  else
    authors = Author.all
    erb :video_edit, locals: {video: video, authors: authors}, layout: "layout"
  end
end

post "/videos" do
  video = Video.new(params[:video])
  if video.save
    redirect to("/video/#{video.slug}")
  else
    authors = Author.all
    erb :video_new, locals: {video: video, authors: authors}, layout: "layout"
  end
end

delete "/videos/:id" do |id|
  video = Video.find(id)
  author_name = video.author.user_name
  video.destroy
  redirect to("/authors/#{author_name}/videos")
end


get "/articles/new" do
  article = Article.new
  authors = Author.all
  erb :article_new, locals: {article: article, authors: authors}, layout: "layout"
end

get "/articles/:id/edit" do |id|
  article = Article.find(id)
  authors = Author.all
  erb :article_edit, locals: {article: article, authors: authors}, layout: "layout"
end

put "/articles/:id" do |id|
  article = Article.find(id)
  article.update_attributes(params[:article])
  if article.save
    redirect to("/article/#{article.slug}")
  else
    authors = Author.all
    erb :article_edit, locals: {article: article, authors: authors}, layout: "layout"
  end
end

post "/articles" do
  article = Article.new(params[:article])
  if article.save
    redirect to("/article/#{article.slug}")
  else
    authors = Author.all
    erb :article_new, locals: {article: article, authors: authors}, layout: "layout"
  end
end

delete "/articles/:id" do |id|
  article = Article.find(id)
  author_name = article.author.user_name
  article.destroy
  redirect to("/authors/#{author_name}/articles")
end