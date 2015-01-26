require File.expand_path '../spec_helper.rb', __FILE__

RSpec::Matchers.define :be_not_empty do
  match do |actual|
    if (actual.respond_to? :empty?)
      !actual.empty?
    else
      true
    end
  end
end

RSpec::Matchers.define :be_url do
  match do |actual|
    uri = URI.parse(actual.to_s)
    %w( http https ).include?(uri.scheme)
  end
end

SEARCH_STRING = 'cats'

describe "Youtube search RSpec" do

  describe "/" do

    it "should allow accessing the default route" do
      get '/'
      expect(last_response).to be_ok
    end

    it "should response with valid JSON on request to /" do
      get '/'
      expect(JSON.parse(last_response.body)).to be_a(Array)
    end

    it "should response with filled titles on request to /" do
      get '/'
      expect(JSON.parse(last_response.body).collect { |item| item['title'] }).to all(be_not_empty.and be_a(String))
    end

    it "should response with filled authors on request to /" do
      get '/'
      expect(JSON.parse(last_response.body).collect { |item| item['author'] }).to all(be_not_empty.and be_a(String))
    end

    it "should response with valid url on request to /" do
      get '/'
      expect(JSON.parse(last_response.body).collect { |item| item['url'] }).to all(be_not_empty.and be_a(String).and be_url)
    end

    it "should response with valid ratings on request to /" do
      get '/'
      expect(JSON.parse(last_response.body).collect { |item| item['rating'] }).to all(be_a(Float).and be_between(1, 5))
    end

  end

  describe "/search/:query" do

    it "should allow accessing the search route" do
      get "/search/#{SEARCH_STRING}"
      expect(last_response).to be_ok
    end

    it "should response with valid JSON on request to /search" do
      get "/search/#{SEARCH_STRING}"
      expect(JSON.parse(last_response.body)).to be_a(Array)
    end

    it "should response with filled titles on request to /search" do
      get "/search/#{SEARCH_STRING}"
      expect(JSON.parse(last_response.body).collect { |item| item['title'] }).to all(be_not_empty.and be_a(String))
    end

    it "should response with filled authors on request to /search" do
      get "/search/#{SEARCH_STRING}"
      expect(JSON.parse(last_response.body).collect { |item| item['author'] }).to all(be_not_empty.and be_a(String))
    end

    it "should response with valid url on request to /search" do
      get "/search/#{SEARCH_STRING}"
      expect(JSON.parse(last_response.body).collect { |item| item['url'] }).to all(be_not_empty.and be_a(String).and be_url)
    end

    it "should response with valid ratings on request to /search" do
      get "/search/#{SEARCH_STRING}"
      expect(JSON.parse(last_response.body).collect { |item| item['rating'] }).to all(be_a(Float).and be_between(1, 5))
    end

  end

end