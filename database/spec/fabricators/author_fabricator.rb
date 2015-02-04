Fabricator(:author) do
  name { Faker::Name.first_name << ' ' << Faker::Name.last_name }
  user_name { Faker::Internet.user_name }
  age { rand(18..50) }
  email { Faker::Internet.free_email }
  website { Faker::Internet.domain_name }
  videos(count: 15)
end