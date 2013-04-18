class DoctorsController < ApplicationController
	
	def serve
		@today = Date.today
       	@doctor = Doctor.find_by_user_id(current_user.id)

       	@reservation = Reservation.where(:schedule_id => params[:schedule_id], :reserved_date => @today, :restype => "not served").first
       	@reservation.update_attributes(:restype => "served")

       	@res = Reservation.where(:schedule_id => params[:schedule_id], :reserved_date => @today)
       	@rank = 0;

       	@res.each do |r| 
			@rank +=1
			if r.restype === "not served"
				break;
			end
       	end

       	@reserva = Reservation.where(:schedule_id => params[:schedule_id], :reserved_date => @today, :restype => "not served")

       	@reserva.each do |r| 
			notif = Notification.new(:user_id => r.user.id, :message => "Dr. "+@doctor.user.lastname+" : NOW SERVING Priority # "+ @rank.to_s+ ".")
       		notif.save	
       	end

       	redirect_to reservations_entertain_path
	end

	def schedule
		@doctor = Doctor.find(params[:id])
		@date =  params[:month] ? Date.parse(params[:month]) : Date.today

		@sked = Schedule.find_by_clinic_name(params[:c_name])
	end

	def new
		@doctor = Doctor.new
	end

	def create
		@doctor = Doctor.new(params[:doctor])
		@user = User.find(@doctor[:user_id])
		if @doctor.save
			@user.update_attributes(:usertype => "doctor")
			redirect_to pages_profile_path
		else
			render "new"
		end
	end

	def profile
		@doctor = Doctor.find_by_user_id(current_user[:id])
		@schedules = Schedule.where(:doctor_id => @doctor.id)
	end

	def show
		@doctor = Doctor.find(params[:id])
		@schedules = Schedule.where(:doctor_id => @doctor.id)
	end

	def edit
		@doctor = Doctor.find_by_user_id(current_user[:id])
	end

	def update
		@doctor = Doctor.find_by_user_id(current_user[:id])

		if @doctor.update_attributes(params[:doctor])
			redirect_to reservations_entertain_path, :notice => "Profile Updated"
		else
			render "edit"
		end
	end

	def selectSearch
		@choice = params[:kind]

		if @choice === "Specialization"
			redirect_to doctors_search_path
		elsif @choice === "Name"
			redirect_to doctors_searchDoctor_path
		elsif @choice === "Clinic"
			redirect_to doctors_searchClinic_path
		end
	end

	def search
		@doctors = Doctor.search(params[:search])
	end

	def searchDoctor
		@users = User.searchDoctor(params[:search])
	end

	def searchClinic
		@skeds = Schedule.search(params[:search])
	end
	
end
