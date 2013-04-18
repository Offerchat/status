ActiveAdmin.register Reservation do
  	index do
	    column :reserved_date
	    column "Served / Not Served",:restype
	    default_actions
	end
end
