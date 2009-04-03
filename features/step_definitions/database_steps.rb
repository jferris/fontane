Given /^a user exists with an email of "([^\"]*)" and a password of "([^\"]*)"$/ do |email, password|
  Fontane::User.create!(:email => email, :password => password)
end

