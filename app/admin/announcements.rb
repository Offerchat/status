ActiveAdmin.register Announcement do

	scope :automatic
  	index do
	    column "Title",:title
	    column "Announcement",:body
	    default_actions
	end

	filter :title    
end
