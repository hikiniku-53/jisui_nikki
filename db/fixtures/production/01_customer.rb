Customer.seed do |s|
  s.id    = 1
  s.email = 'king@example.com'
  s.name = 'cooKING'
  s.password = '3214-5678'
  s.password_confirmation = '3214-5678'

end

Customer.seed do |s|
  s.id    = 2
  s.email = 'ryori@example.com'
  s.name = '料理太郎'
  s.password = '5678-9012'
  s.password_confirmation = '5678-9012'

end