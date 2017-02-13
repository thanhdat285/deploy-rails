class User < ApplicationRecord
  before_save :check_confirmation
  before_save :encrypt_password

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 6}

  has_many :financials, dependent: :destroy

  attr_accessor :password_confirmation

  def authenticate! pass
    self.password == Digest::SHA1.hexdigest(Settings.code + pass + self.username)
  end

  private
  def check_confirmation
    self.password.eql?(self.password_confirmation)
  end

  def encrypt_password
    self.password = Digest::SHA1.hexdigest(Settings.code + self.password + self.username)
  end
end
