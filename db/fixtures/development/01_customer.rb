Customer.seed do |s|
  s.id    = 1
  s.email = 'KING@example.com'
  s.name = 'cooKING'
  s.password = '1234'
  s.password_confirmation = s.password

end

Customer.seed do |s|
  s.id    = 2
  s.email = 'ryori@example.com'
  s.name = '料理太郎'
  s.password = '5678'
  s.password_confirmation = s.password

end