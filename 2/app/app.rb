get '/' do
  partial(:"home", :locals => {videos: YouTubeSearch::search(:top_rated => 1, :time => :today, :per_page => 10)})
end

get '/most_viewed' do
  partial(:"most_viewed", :locals => {videos: YouTubeSearch::search(:most_viewed => 1, :per_page => 10)})
end

get '/search/:query' do |query|
  partial(:"search", :locals => {videos: YouTubeSearch::search(:query => query.to_s, :per_page => 10), q: query})
end