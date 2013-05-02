class Announcement < ActiveRecord::Base
	attr_accessible :title, :body, :auto
	scope :automatic, where(:auto => true)
end
