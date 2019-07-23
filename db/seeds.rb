User.create(
  username: "Stan Smith",
  email: "stan@smith.com",
  password: "qwerty"
)

3.times do |index|
  Sneaker.create(
    context: "#{index}",
    number: 123,
    user_id: 1
  )
end
