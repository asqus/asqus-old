
jake_schwartz = 
  User.create(
    :first_name => 'Jake',
    :last_name => 'Schwartz',
    :email => 'jake@asq.us',
    :password => 'asdfasdf',
    :encrypted_password => "$2a$10$eG5ccm77VIotfxwo0jmySuHhvUnaR8fH1Sjf7do9BJbwlVfPhhk36",
    :zipcode => '48104',
    :admin => true
  )


adam_williams = 
  User.create({
    :first_name => 'Adam',
    :last_name => 'Williams',
    :email => 'adam@asq.us',
    :zipcode => '49341',
    :password => 'asdfasdf',
    :encrypted_password => "$2a$10$eG5ccm77VIotfxwo0jmySuHhvUnaR8fH1Sjf7do9BJbwlVfPhhk36",
    :admin => true
  })


brad_chick = User.create({
  :first_name => 'Brad',
  :last_name => 'Chick',
  :email => 'brad@asq.us',
  :zipcode => '48471',
  :password => 'asdfasdf',
  :encrypted_password => "$2a$10$eG5ccm77VIotfxwo0jmySuHhvUnaR8fH1Sjf7do9BJbwlVfPhhk36",
  :admin => true
})


rick_snyder = 
  User.create(
    :first_name => 'Rick',
    :last_name => 'Snyder',
    :email => 'rick@snyder.com',
    :password => 'asdfasdf',
    :encrypted_password => "$2a$10$eG5ccm77VIotfxwo0jmySuHhvUnaR8fH1Sjf7do9BJbwlVfPhhk36",
    :zipcode => '48854',
    :admin => false
  )
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
    :password => 'asdfasdf',
    :encrypted_password => "$2a$10$eG5ccm77VIotfxwo0jmySuHhvUnaR8fH1Sjf7do9BJbwlVfPhhk36",
    :zipcode => '49501',
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

john_hieftje =
  User.create({
    :first_name => 'John',
    :last_name => 'Hieftje',
    :email => 'jhieftje@ci.ann-arbor.mi.us',
    :password => 'asdfasdf',
    :encrypted_password => "$2a$10$eG5ccm77VIotfxwo0jmySuHhvUnaR8fH1Sjf7do9BJbwlVfPhhk36",
    :zipcode => '48104',
    :admin => false
  })
  Rep.create({
    :user_id => john_hieftje.id,
    :title => 'Mayor of Ann Arbor',
    :state_id => 23,
    :district => '99',
    :chamber => 'mayor',
    :level => 'city'
  })

yes_or_no = 
  PollOptionSet.create(
    :options_type => 'binary',
    :num_options => 2,
    :options => "  { \"0\": \"Yes\", \"1\": \"No\" }  "
  )

agree_scale = 
  PollOptionSet.create(
    :options_type => 'multiple',
    :num_options => 4,
    :options => "  { \"0\": \"Strongly Disagree\", \"1\": \"Disagree\", \"2\": \"Agree\", \"3\": \"Strongly Agree\"}  "
  )

Poll.create({
  :creator_id => justin_amash.id,
  :title => 'Do you support CISPA?',
  :prompt => 'H R 3523, Cyber Intelligence Sharing and Protection Act (CISPA). The bill exempts private entities and utilities from all state and federal liability when they share "cyber threat information" with the federal government. That term is defined broadly to mean any information "directly pertaining to . . . [a] threat to [] a system or network," and it may include your personally identifiable information.

The bill also provides new authority to the federal government to share your information with the private sector. The government may use information it receives from companies for purposes beyond cybersecurity, including protecting minors and national security.',
  :poll_option_set_id => yes_or_no.id,
  :published => true
})


Poll.create({
  :creator_id => rick_snyder.id,
  :title => 'Do you think we should expand cyber charter schools in Michigan?',
  :prompt => 'For more information, click here: <a
href="http://www.legislature.mi.gov/(S(pncoiw45kbdn4laj03leie45))/mileg.aspx?page=getobject&objectname=2011-SB-0619">http://www.legislature.mi.gov/</a>',
  :poll_option_set_id => agree_scale.id,
  :published => true
})


Poll.create({
  :creator_id => john_hieftje.id,
  :title => "What do you think about the plan to install Herbert Dreiseitl's
750k statue in front of the new Justice Center building and a newly renovated
city hall?",
  :prompt => "In 2007, Ann Arbor's City Council unanimously passed an ordinance stipulating that all capital improvement projects funded wholly or partly by the City will include funds for public art equal to one percent of the project construction costs, to a maximum of $250,000 per capital improvement project. Public art may be located at the capital improvement site, or can be installed at other locations. Public art must relate to the funding source of the capital improvement.
For more information, <a
href='http://www.a2gov.org/government/publicservices/Pages/aapac.aspx'>click
here</a>",
  :poll_option_set_id => yes_or_no.id,
  :published => true
})


Poll.create({
  :creator_id => adam_williams.id,
  :title => 'Title',
  :prompt => 'Do you support SOPA/PIPA?',
  :poll_option_set_id => yes_or_no.id,
  :published => true
})


Poll.create({
  :creator_id => jake_schwartz.id,
  :title => 'Title2',
  :prompt => 'Prompt2',
  :poll_option_set_id => agree_scale.id,
  :published => true
})


