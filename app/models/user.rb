class User < ActiveRecord::Base
	attr_accessible :address,:birthdate,:contact_number,:email,:sex,:usertype,:name,:firstname,:lastname,:image

	has_many :reservations, :dependent => :destroy
	has_many :notifications, :dependent => :destroy

	validates :email ,:uniqueness => { :message => "Email already taken"}
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
	validates_numericality_of :contact_number
	validates :address, :contact_number,:email,:sex,:birthdate,:name,:firstname,:lastname, :presence => true
	validates :contact_number, :length => { :minimum => 7}

	def self.from_omniauth(auth)
	  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
	      user.provider = auth.provider
	      user.uid = auth.uid
	      user.name = auth.info.name 
	      user.lastname = auth.info.last_name
	      user.firstname = auth.info.first_name
	      user.image = auth.info.image
	      user.oauth_token = auth.credentials.token
	      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	      user.save(:validate => false)
	  end
  	end

  	def self.searchDoctor(search)
	    if search
	      where('name LIKE ? AND usertype = ?', "%#{search}%","doctor")
	    else
	      where('usertype = ?', "doctor")
	    end
	end
end
