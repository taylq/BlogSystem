puts "Seeding User"
99.times do |i|
  User.create!(name: "User #{i}", password: "123456", password_confirmation: "123456",
    email: "user#{i}@framgia.com")
end

puts "Seeding Blog"
users = User.order(:created_at).take(6)
50.times do
  title = Faker::LeagueOfLegends.champion
  content = Faker::Lorem.sentence(5)
  users.each {|user| user.blogs.create!(title: title, content: content)}
end

puts "Seeding Follower"
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
