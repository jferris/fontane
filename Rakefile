require 'rubygems'
require 'activerecord'

task :environment do
  require 'app'
end

namespace :db do
  desc "Migrate the database"
  task :migrate => :environment do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("migrations")
  end
end

