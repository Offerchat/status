ActiveAdmin.register Doctor do
  	
	index do
	    column "Educational Attainment",:ed_attainment
	    column :specialization
	    column :office_address
	    column "Office Contact Number",:office_contact
	    default_actions
	end

end
