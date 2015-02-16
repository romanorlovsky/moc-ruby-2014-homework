Fabricator(:video) do
  title { Faker::Lorem.words(rand(2..5)).join(' ') }
  slug { |attrs| Faker::Internet.slug(attrs[:title].parameterize << ' ' << rand(1..100).to_s, '-') }
  description { Faker::Lorem.sentence }
  url { Faker::Internet.url('youtu.be/', Faker::Lorem.characters(11)) }
  comments(count: 15)
end