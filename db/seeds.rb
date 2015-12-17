include Faker

standard = User.create!(
  email: 'gsxr370k6@yahoo.com',
  password: 'helloworld'
  )

admin = User.create!(
  email: 'pfluegelcx@gmail.com',
  password: 'helloworld',
  role: 'admin'
  )

users = User.all

10.times do 
  Wiki.create!(
    user: users.sample,
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraphs(2)
    )
end
  
   
    
  
puts "Seeds finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
