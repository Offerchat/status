require 'net/http'
require 'uri'

class StatusController < ApplicationController
  def index

  	tweet = Feedzirra::Feed.fetch_and_parse("http://api.twitter.com/1/statuses/user_timeline.rss?screen_name=offerchat")
  	@tweets = tweet.entries.first(5)

  	@site_is_up = pingSite
    @server_is_up = pingServer 


    
	    if @site_is_up and @server_is_up #both are true
	    	if Announcement.where(:auto => true).count % 2 === 1
	    		announce("We're back in business!","All systems are up. We're sorry for the inconvenience.")
	    	end
	    elsif @site_is_up and !@server_is_up #site is up, server down
	    	announce("Chat Server Connection Issues","There are some connection issues with our Chat Server. We are doing our best to fix this.")
	    elsif !@site_is_up and @server_is_up #site is down, server up
	    	announce("Offerchat Connection Problems","We are experiencing some connection issues with Offerchat. Our developers are working on that.")
	    elsif !@site_is_up and !@server_is_up #both are down
	    	announce("We got a serious problem here, mate.","Both the Chat Server and the Offerchat site are down. We are doing our best to fix this.")
	    end

	@posts = Announcement.paginate(:order => "created_at DESC", :per_page => 3, :page => params[:page])

  end


  def view
  	@post = Announcement.find(params[:id])

  	tweet = Feedzirra::Feed.fetch_and_parse("http://api.twitter.com/1/statuses/user_timeline.rss?screen_name=offerchat")
  	@tweets = tweet.entries.first(5)
  end

  def announce(title,message)
  	first = Announcement.where(:auto => true).order("created_at DESC").first()
  	
	if first
		if first.body != message 
		  		post = Announcement.new(:title => "#{title}", :body => "#{message}" ,:auto=>true, :created_at=>Time.now.strftime("%B %d, %Y %I:%M %p") )
		  		post.save
		  		Twitter.update("[Update:" + Date.today.strftime("%B %d") + Time.now.strftime("-%I:%M %p")+"] #{message}" )
		end
	else
		post = Announcement.new(:title => "#{title}", :body => "#{message}", :auto=>true)
	  	post.save
	  	Twitter.update("[Update:" + Date.today.strftime("%B %d") + Time.now.strftime("-%I:%M %p")+"] #{message}" )
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
	rescue Errno::ETIMEDOUT
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
	rescue Errno::ETIMEDOUT
		return false
	end

	if response.code.to_i === 200
		return true
	else
		return false
	end
  end
end
