class Doctor < ActiveRecord::Base
	attr_accessible :ed_attainment, :specialization, :office_address, :office_contact,:user_id

	belongs_to :user
	has_many :schedules, :dependent => :destroy

	validates_numericality_of :office_contact
	validates_uniqueness_of :user_id
	validates :ed_attainment, :specialization, :office_address, :office_contact, :presence => true
	validates :office_contact, :length => { :minimum => 7}

	  def self.search(search)
	    if search
	      where('specialization LIKE ?', "%#{search}%")
	    else
	      scoped
	    end
	  end
end
