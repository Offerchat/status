require 'net/http'
require 'uri'

class StatusController < ApplicationController
  def index
  	feed = Feedzirra::Feed.fetch_and_parse("http://blog.offerchat.com/feed")
  	@feeds = feed.entries.first(5)

  	tweet = Feedzirra::Feed.fetch_and_parse("http://api.twitter.com/1/statuses/user_timeline.rss?screen_name=offerchat")
  	@tweets = tweet.entries.first(5)

	

  	@site = pingSite
	    
    @server = pingServer
	 
  end

  def pingSite
    uri = URI.parse("https://offerchat.com/")
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE

	request = Net::HTTP::Get.new(uri.request_uri)

	response = http.request(request)  

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

	response = http.request(request)  

	if response.code.to_i === 200
		return true
	else
		return false
	end
  end
end
