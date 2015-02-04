Fabricator(:video) do
  title { Faker::Lorem.words(rand(2..5)).join(' ') }
  description { Faker::Lorem.sentence }
  url { Faker::Internet.url('youtu.be/', Faker::Lorem.characters(11)) }
end