ActiveAdmin.register Schedule do
  	index do
	    column :day
	    column :clinic_name
	    column "Clinic Address",:address
	    column "Clinic Contact Number",:contact_num
	    column :start_time
	    column :end_time
	    column "Maximum Number of Slots",:max_slots
	    default_actions
	end
end
