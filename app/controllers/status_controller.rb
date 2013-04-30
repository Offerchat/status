require 'net/http'
require 'uri'

class StatusController < ApplicationController
  def index
  	@posts = Announcement.order("created_at DESC").first(3)

  	#tweet = Feedzirra::Feed.fetch_and_parse("http://api.twitter.com/1/statuses/user_timeline.rss?screen_name=offerchat")
  	#@tweets = tweet.entries.first(5)

  	begin
  		Twitter.update("[Update:" + Date.today.strftime("%B %d ") + Time.now.strftime("%I:%M")+"] welcome to offerchat!" )
  	rescue Twitter::Error::Forbidden
  	end
  	

  	@site = pingSite
	    
    @server = pingServer
	 
  end

  def view
  	@post = Announcement.find(params[:id])

  	#tweet = Feedzirra::Feed.fetch_and_parse("http://api.twitter.com/1/statuses/user_timeline.rss?screen_name=offerchat")
  	#@tweets = tweet.entries.first(5)
  end


  def pingSite
    uri = URI.parse("https://offerchat.com/")
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE

	request = Net::HTTP::Get.new(uri.request_uri)

	begin
		response = http.request(request)  

	rescue Timeout::Error
		return false
	rescue Errno::ECONNREFUSED
		return false
	end

	if response.code.to_i === 200
		return true
	else
		return false
	end
  end

  def pingServer
	uri = URI.parse("http://realtime.offerchat.com:9090/login.jsp")
	http = Net::HTTP.new(uri.host, uri.port)

	request = Net::HTTP::Get.new(uri.request_uri)

	begin
		response = http.request(request)  
	rescue Errno::ECONNREFUSED
		return false
	rescue Timeout::Error
		return false
	end

	if response.code.to_i === 200
		return true
	else
		return false
	end
  end
end
