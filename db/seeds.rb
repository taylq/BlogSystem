puts "Seeding User"
7.times do |i|
  User.create!(name: "User #{i}", password: "123456", password_confirmation: "123456",
    email: "user#{i}@framgia.com")
end

puts "Seeding Blog"
users = User.order(:created_at).take(6)
15.times do
  title = Faker::LeagueOfLegends.champion
  content = Faker::Lorem.sentence(5)
  users.each {|user| user.blogs.create!(title: title, content: content)}
end
