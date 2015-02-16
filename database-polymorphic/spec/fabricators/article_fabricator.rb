Fabricator(:article) do
  title { Faker::Lorem.words(rand(2..5)).join(' ') }
  slug { |attrs| Faker::Internet.slug(attrs[:title].parameterize << ' ' << rand(1..100).to_s, '-') }
  content { Faker::Lorem.paragraph }
  comments(count: 20)
end