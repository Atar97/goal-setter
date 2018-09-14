# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  
  validates :username, :password_digest, :session_token, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true}
  
  after_initialize :ensure_session_token
  attr_reader :password
  
  
  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end 
  
  def self.create_session_token
    SecureRandom.urlsafe_base64
  end
  
  def ensure_session_token
    self.session_token ||= User.create_session_token
  end
  
  def reset_session_token!
    self.session_token = User.create_session_token
  end
  
  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    
    if user
      return user if user.is_password?(password)
    end
    
    nil   
  end
  
end
