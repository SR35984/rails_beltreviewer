class User < ActiveRecord::Base
  has_secure_password
  has_many :events, dependent: :destroy
  has_many :attends
  has_many :attending, through: :attends, source: :event

  before_save :setCase

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :location, presence: true, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :state, presence: true, length: { is: 2 }

  def setCase
    self.first_name.titleize!
    self.last_name.titleize!
    self.email.downcase!
    self.location.titleize!
    self.state.upcase!
  end

end
