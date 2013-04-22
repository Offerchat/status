class StatusController < ApplicationController
  def index
  	@update = FeedEntry.update_from_feed("http://blog.offerchat.com/feed")
  	@feeds = FeedEntry.all
  end
end
