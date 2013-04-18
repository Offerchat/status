class NotificationsController < ApplicationController
	def remove
		@notif = Notification.find(params[:id])

		@notif.destroy

		redirect_to reservations_path, :notice => "Notification deleted"
	end
end
