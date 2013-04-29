ActiveAdmin.register Announcement do
  	index do
	    column "Title",:title
	    column "Announcement",:body
	    default_actions
	end
end
