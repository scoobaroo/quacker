User.destroy_all
Ilter = User.create({
        username: "BotCreon",
        email: "1@1.com",
        password_digest: "1",
        current_city: "San Francisco"
  })

puts "Seed completed"
