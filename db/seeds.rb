User.destroy_all
Tweet.destroy_all
Ilter = User.create({
        username: "BotCreon",
        email: "1@1.com",
        password_digest: "1",
        current_city: "San Francisco"
  })

20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(username: name,
              email: email,
              password: password,
              current_city: Faker::Address.city)
end

# Microposts
users = User.order(:created_at).take(6)
25.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.tweets.create!(title: content, body: content) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..20]
followers = users[3..15]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

puts "Seed completed"
