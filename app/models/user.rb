class User < ActiveRecord::Base
  has_secure_password
	has_many :events_created, :foreign_key => "user_id", source: :event
	has_many :events, :through => :attends
	has_many :attends
	has_many :comments

	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

	validates :first_name, :last_name, presence: true, length: { minimum: 2 }
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

	before_save :email_lowercase

	def email_lowercase
		email.downcase!
	end
end
