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

users.each do |u|
  role = Devx::Role.find_by(name: 'Super Administrator')
  u.authorizations.create(role: role)
end

Devx::Branding.create(id: 1)

products = Devx::Product.create([
    {
      name: 'Product 1',
      description: 'Lorem ipsum'
    },
    {
      name: 'Product 2',
      description: 'Lorem ipsum'
    },
    {
      name: 'Product 3',
      description: 'Lorem ipsum'
    },
    {
      name: 'Product 4',
      description: 'Lorem ipsum'
    },
    {
      name: 'Product 5',
      description: 'Lorem ipsum'
    },
    {
      name: 'Product 6',
      description: 'Lorem ipsum'
    },
])

products.each do |p|
  p.product_skus.create(currency: 'USD', price: 9.99, stockable: false, active: true)
end
