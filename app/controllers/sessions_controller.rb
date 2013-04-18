class SessionsController < ApplicationController
  def create
    @user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = @user.id

    search = User.find(@user.id)
    
    if search.usertype?
      if search.contact_number?
        redirect_to pages_profile_path
      end
    else      
      redirect_to pages_signup_path
    end
   
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url
  end
end