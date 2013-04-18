class PagesController < ApplicationController
	def index
		if current_user
			if current_user.email?
			 redirect_to pages_profile_path
			else
 			 redirect_to pages_signup_path
			end
		end
	end

	def signup
		@user = User.find(current_user[:id])
	end

	def profile
		@user = User.find(current_user[:id])

		if @user.usertype === "patient"
			redirect_to reservations_path, :notice => "Welcome "+@user.name + "!"
		elsif @user.usertype === "doctor"
			@doctor = Doctor.find_by_user_id(current_user[:id])
			if @doctor
				
				redirect_to reservations_entertain_path,:notice => "Welcome Dr."+@user.lastname + "! Here are your patients for today."
			else
				redirect_to new_doctor_path
			end
		else
			redirect_to pages_path
		end	
	end

end
