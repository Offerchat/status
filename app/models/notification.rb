class Notification < ActiveRecord::Base
	attr_accessible :user_id, :message

	belongs_to :user

	validates :user_id, :message, :presence => true
end
