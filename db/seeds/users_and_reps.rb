
User.create({
  :first_name => 'Jake',
  :last_name => 'Schwartz',
  :email => 'jake@asq.us',
  :encrypted_password => "$2a$10$eG5ccm77VIotfxwo0jmySuHhvUnaR8fH1Sjf7do9BJbwlVfPhhk36",
  :zipcode => 48104,
  :admin => true
})


User.create({
  :first_name => 'Adam',
  :last_name => 'Williams',
  :email => 'adam@asq.us',
  :zipcode => 49341,
  :encrypted_password => "$2a$10$eG5ccm77VIotfxwo0jmySuHhvUnaR8fH1Sjf7do9BJbwlVfPhhk36",
  :admin => true
})


User.create({
  :first_name => 'Brad',
  :last_name => 'Chick',
  :email => 'brad@asq.us',
  :zipcode => 48471,
  :encrypted_password => "$2a$10$eG5ccm77VIotfxwo0jmySuHhvUnaR8fH1Sjf7do9BJbwlVfPhhk36",
  :admin => true
})


rick_snyder = 
  User.create({
    :first_name => 'Rick',
    :last_name => 'Snyder',
    :email => 'rick@snyder.com',
    :encrypted_password => "$2a$10$eG5ccm77VIotfxwo0jmySuHhvUnaR8fH1Sjf7do9BJbwlVfPhhk36",
    :zipcode => 48854,
    :admin => false
  })
  Rep.create({
    :user_id => rick_snyder.id,
    :title => 'Michigan governor',
    :state_id => 23,
    :district => '23',
    :chamber => 'governor',
    :level => 'governor'
  })


justin_amash =
  User.create({
    :first_name => 'Justin',
    :last_name => 'Amash',
    :email => 'justin@amash.com',
    :encrypted_password => "$2a$10$eG5ccm77VIotfxwo0jmySuHhvUnaR8fH1Sjf7do9BJbwlVfPhhk36",
    :zipcode => 49501,
    :admin => false
  })
  Rep.create({
    :user_id => justin_amash.id,
    :title => 'Michigan state representative',
    :state_id => 23,
    :district => '3',
    :chamber => 'house',
    :level => 'national'
  })


