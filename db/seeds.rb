users = Devx::User.create([
  {
    email: 'demo@devxcms.com',
    first_name: 'Rashaad',
    last_name: 'Randall',
    password: 'password'
  },

  {
    email: 'david@jcwproductions.com',
    first_name: 'Dave',
    last_name: 'Beatz',
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

Devx::Permission.create([
    {
      role: Devx::Role.find_by(name: 'Super Administrator'),
      object_class: 'all',
      action: 'manage'
    }
])

users.each do |u|
  role = Devx::Role.find_by(name: 'Super Administrator')
  u.authorizations.create(role: role)
end

Devx::Branding.create(id: 1)
