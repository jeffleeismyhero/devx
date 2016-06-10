users = Devx::User.create([
  {
    email: 'rashaad@jcwproductions.com',
    first_name: 'Rashaad',
    last_name: 'Randall',
    password: 'password'
  }
])

Devx::Role.create([
  {
    name: 'Super Administrator'
  },
  {
    name: 'Administrator'
  },
  {
    name: 'Developer'
  },
  {
    name: 'Parent'
  },
  {
    name: 'Student'
  },
  {
    name: 'Faculty'
  },
  {
    name: 'Alumni'
  }
])

users.each do |u|
  role = Devx::Role.find_by(name: 'Super Administrator')
  u.authorizations.create(role: role)
end