Fabricator(:comment) do
  content { Faker::Lorem.sentence(rand(2..10)) }
end