# RSpec matchers
require 'spec/expectations'

# Webrat
gem 'jferris-webrat'
require 'webrat'

Webrat.configure do |config|
  config.mode = :sinatra
end

app_file = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'app'))
require app_file
Sinatra::Application.app_file = app_file

World do
  session = Webrat::SinatraSession.new
  session.extend(Webrat::Matchers)
  session.extend(Webrat::HaveTagMatcher)
  session
end
