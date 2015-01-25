get '/' do
  JSON.pretty_generate(YouTubeSearch::search(:top_rated => 1, :time => :today, :per_page => 10))
end

get '/most_viewed' do
  JSON.pretty_generate(YouTubeSearch::search(:most_viewed => 1, :per_page => 10))
end

get '/search/:query' do |query|
  unless query.to_s.empty?
    JSON.pretty_generate(YouTubeSearch::search(:query => query.to_s, :per_page => 10), q: query)
  else
    status 404
    {error: "Not found"}.to_json
  end
end