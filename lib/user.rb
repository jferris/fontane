require 'digest/md5'

class User < ActiveRecord::Base
  attr_accessor :password

  before_save :set_password_hash, :if => :password_changed?

  def self.authenticate(email, password)
    find_by_email_and_password_hash(email, hash_value(password))
  end

  private

  def self.hash_value(value)
    Digest::MD5.hexdigest(value)
  end

  def set_password_hash
    self.password_hash = self.class.hash_value(password)
  end

  def password_changed?
    password.present?
  end
end
