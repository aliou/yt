class User < ActiveRecord::Base
  validate :mail, presence: true, uniqueness: true
  validate :password_digest, presence: true
end
