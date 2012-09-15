class User < ActiveRecord::Base
  attr_accessible :login, :nombre, :password, :password_confirmation

  acts_as_authentic do |config|
    config.crypto_provider = Authlogic::CryptoProviders::MD5
  end
end
