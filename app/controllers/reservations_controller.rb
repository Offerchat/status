class ReservationsController < ApplicationController
	def entertain	
       @today = Date.today
       @doctor = Doctor.find_by_user_id(current_user.id)
       @schedule =  Schedule.where("doctor_id = ? AND day = ?", @doctor.id, @today.strftime("%A"))
    
	end

	def index
		@reservations = Reservation.where(:user_id => current_user.id, :restype => "not served").order("reserved_date ASC")		
		@notifs = Notification.where(:user_id => current_user.id)
	end

	def create
		@date = Date.parse(params[:date])
		@reservation = Reservation.new(:schedule_id => params[:schedule_id],:reserved_date => @date, :user_id => params[:user_id],:restype => "not served")

		if @reservation.save
			redirect_to reservations_path, :notice => "Your reservation has been added to the list. View reservations below for more details."
		else
			redirect_to doctors_schedule_path(:id => @reservation.schedule.doctor.id), :notice => "Invalid Date, must be on or after today."
		end
	end

	def view
		@date = Date.parse(params[:reserved_date])
		@reservations = Reservation.where("schedule_id = ? AND reserved_date = ?", params[:schedule_id], @date)
		@doctor = Doctor.find_by_user_id(current_user[:id])
	end

end
