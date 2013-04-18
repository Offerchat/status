class Reservation < ActiveRecord::Base
	attr_accessible :reserved_date, :schedule_id, :user_id, :restype

	belongs_to :schedule
	belongs_to :user


	validates :reserved_date, :schedule_id,:user_id,:restype, :presence => true

	validates_date :reserved_date, :on_or_after => Date.today,
                               :on_or_after_message => "INVALID DATE"
end
