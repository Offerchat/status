ActiveAdmin.register User do

	index do
	    column :name
	    column :email
	    column :address
	    column :contact_number
	    column "Birthday", :birthdate
	    column :sex
	    column "Type",:usertype
	    default_actions
	end
  	
end
