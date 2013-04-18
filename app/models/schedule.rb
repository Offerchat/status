class Schedule < ActiveRecord::Base
	attr_accessible :doctor_id, :day,:clinic_name,:address,:contact_num,:max_slots,:start_time,:end_time

	belongs_to :doctor
	has_many :reservations, :dependent => :destroy

	validates_numericality_of :contact_num
	validates :day,:clinic_name,:address,:contact_num,:max_slots,:start_time,:end_time, :presence => true
	validates :contact_num, :length => { :minimum => 7}
	validates :max_slots, :inclusion => { :in => 5..20, :message => "%{value} is not a valid size" }
	validates_datetime :end_time, :after => :start_time, :after_message => "INVALID"
	validates :day,:uniqueness => {:scope => [:start_time,:end_time]}

	def self.search(search)
	    if search
	      where('clinic_name LIKE ? OR address LIKE ?', "%#{search}%","%#{search}%")
	    else
	      where('doctor_id != ?',0).uniq
	    end
	end
end
