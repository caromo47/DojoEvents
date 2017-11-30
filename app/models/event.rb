class Event < ActiveRecord::Base
  belongs_to :user
	has_many :attends, dependent: :destroy
	has_many :users, :through => :attends
	has_many :comments, dependent: :destroy

	validate :date_cannot_be_past
	validates :name, :location, presence: true, length: { minimum: 2 }
	validates :date, presence: true

	def date_cannot_be_past
		errors.add(:date, "Can't be in the past") if
		!date.blank? and date < Date.today
	end
end
