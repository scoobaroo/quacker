User.destroy_all
Tweet.destroy_all
Ilter = User.create({
       username: "BotCreon",
       email: "1@1.com",
       password_digest: "1",
       current_city: "San Francisco"
 })

10.times do |n|
 email = "example-#{n+1}@railstutorial.org"
 password = "password"
 User.create!(username: Faker::Internet.user_name,
             email: email,
             password: password,
             current_city: Faker::Address.city)
end

# Microposts
users = User.order(:created_at).take(6)
5.times do
 content = Faker::Lorem.paragraph(1)
 title = Faker::Lorem.sentence(4)
 users.each { |user| user.tweets.create!(title: title, body: content, latitude: rand(-90..90), longitude: rand(-180..180)) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..10]
followers = users[3..7]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

puts "Seed completed"
