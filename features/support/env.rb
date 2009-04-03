# RSpec matchers
require 'spec/expectations'

# Webrat
gem 'jferris-webrat'
require 'webrat'

Webrat.configure do |config|
  config.mode = :sinatra
end

$: << File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib'))
require 'fontane'

# Webrat expects an object that responds to #app, but Sinatra::Application does
# not. Is there a better way to do this?
app = Object.new
def app.app
  Fontane::Application
end

World do
  session = Webrat::SinatraSession.new(app)
  session.extend(Webrat::Matchers)
  session.extend(Webrat::HaveTagMatcher)
  session
end
