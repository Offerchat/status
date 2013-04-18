class SchedulesController < ApplicationController
	def index
		@doctor = Doctor.find_by_user_id(current_user[:id])
		@schedules = Schedule.where("doctor_id = ?", @doctor.id).order("day")
	end

	def new
		@schedule = Schedule.new
		@doctor = Doctor.find_by_user_id(current_user[:id])
	end

	def create
		@schedule = Schedule.new(params[:schedule])
		@doctor = Doctor.find_by_user_id(current_user[:id])
		@schedule.doctor_id = @doctor.id

		if @schedule.save
			redirect_to schedules_path, :notice => "Schedule added"
		else
			render "new"
		end
	end

	def edit
		@schedule = Schedule.find(params[:id])
		@doctor = Doctor.find_by_user_id(current_user[:id])
	end

	def update
		@schedule = Schedule.find(params[:id])

		if @schedule.update_attributes(params[:schedule])
			redirect_to schedules_path,:notice => "Schedule updated"
		else
			render "edit"
		end
	end

	def remove
		@schedule = Schedule.find(params[:id])
		
		@schedule.destroy

		redirect_to schedules_path, :notice => "Schedule removed"
	end
end
