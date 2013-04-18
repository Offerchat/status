class UsersController < ApplicationController
	def update
		@user = User.find(params[:id])
		@doctor = Doctor.find_by_user_id(params[:id])

		if @user.update_attributes(params[:user])
			if @user.usertype === "patient"
				redirect_to pages_profile_path
			elsif @user.usertype === "doctor"
				if @doctor
					redirect_to edit_doctor_path(@doctor)
				else
					redirect_to new_doctor_path
				end 
			else
				redirect_to pages_profile_path,:notice => "Welcome "+@user.name + "! Find your doctor now."
			end
		else
				render "edit"

		end
	end

	def edit
		@user = User.find(params[:id])
		@doctor = Doctor.find_by_user_id(params[:id])

		@user.usertype = params[:usertype]

	end
end
