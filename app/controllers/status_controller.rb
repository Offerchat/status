require 'net/http'
require 'uri'

class StatusController < ApplicationController
  def index
  	#tweet = Feedzirra::Feed.fetch_and_parse("http://api.twitter.com/1/statuses/user_timeline.rss?screen_name=offerchat")
  	#@tweets = tweet.entries.first(5)

<<<<<<< HEAD
  	@site_is_up = pingSite
    @server_is_up = pingServer

    if @site_is_up and @server_is_up #both are true
    	unless Announcement.count === 0
    		announce("We're back in business!","All systems are up. We're sorry for the inconvenience.")
    	end
    elsif @site_is_up and !@server_is_up #site is up, server down
    	announce("Chat Server Connection Issues","There are some connection issues with our Chat Server. We are doing our best to fix this.")
    elsif !@site_is_up and @server_is_up #site is down, server up
    	announce("Offerchat Connection Problems","We are experiencing some connection issues with Offerchat. Our developers are working on that.")
    elsif !@site_is_up and !@server_is_up #both are down
    	announce("We got a serious problem here, mate.","Both the Chat Server and the Offerchat site are down. We are doing our best to fix this. We're sorry for the inconvenience.")
    end

	@posts = Announcement.order("created_at DESC").first(3)
=======
  	begin
  		Twitter.update("[Update:" + Date.today.strftime("%B %d ") + Time.now.strftime("%I:%M")+"] welcome to offerchat!" )
  	rescue Twitter::Error::Forbidden
  	end
  	
>>>>>>> ebe709a7b448194a262608b4b6e427806a01f095

  end

  def view
  	@post = Announcement.find(params[:id])

  	#tweet = Feedzirra::Feed.fetch_and_parse("http://api.twitter.com/1/statuses/user_timeline.rss?screen_name=offerchat")
  	#@tweets = tweet.entries.first(5)
  end

  def announce(title,message)
  	first = Announcement.order("created_at DESC").first()

	if first
	  	if first.body != message
	  		post = Announcement.new(:title => "#{title}", :body => "#{message}")
	  		post.save
	  	end
	else
		post = Announcement.new(:title => "#{title}", :body => "#{message}")
	  	post.save
	end

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
