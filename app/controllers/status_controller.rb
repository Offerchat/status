require 'net/http'

class StatusController < ApplicationController
  def index
  	#@update = FeedEntry.update_from_feed("http://blog.offerchat.com/feed")
  	@feeds = FeedEntry.all

  	@x = pingSite
  	if @x.to_i === 301
  		@site = true
  	end

  	@y = pingServer
  	if @y.to_i === 200
  		@server = true
  	end
  end

  
  def pingSite
  	https = Net::HTTP.new('www.offerchat.com',80)
  	begin
		response = https.request_get('/')
		return response.code
	rescue Errno::ECONNREFUSED
		return "0"
	rescue Timeout::Error
		return "0"
	rescue Errno::ETIMEDOUT
		return "0"
	end	
  end

  def pingServer
  	https = Net::HTTP.new('realtime.offerchat.com',9090)
	begin
		response = https.request_get('/')
		return response.code
	rescue Errno::ECONNREFUSED
		return "0"
	rescue Timeout::Error
		return "0"
	end
  end

end
