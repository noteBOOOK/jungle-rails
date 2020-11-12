class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by_email(params[:email])
    # If user exists AND password is correct
    if user && user.authenticate(params[:password])
      # Save the user id inside the browswer cookie
      session[:user_id] = user.id
      redirect_to '/'
    else
      # If failed login, redirect back to login form
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end



end
