Given /^a user exists with an email of "([^\"]*)" and a password of "([^\"]*)"$/ do |email, password|
  User.create!(:email => email, :password => password)
end

