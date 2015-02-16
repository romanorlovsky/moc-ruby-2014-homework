Fabricator(:author) do
  name { Faker::Name.first_name << ' ' << Faker::Name.last_name }
  user_name { |attrs| Faker::Internet.user_name(attrs[:name].parameterize, %w(-)) }
  age { rand(18..50) }
  email { |attrs| Faker::Internet.safe_email(attrs[:name].parameterize) }
  website { Faker::Internet.domain_name }
  videos(count: 15)
  articles(count: 25)
end