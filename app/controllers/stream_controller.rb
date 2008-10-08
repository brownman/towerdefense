class StreamController < ApplicationController
  def part
    # This should remove us from a game/channel
    
    # should do a render juggernaut and tell all user lists in parted channels to refresh
    render :nothing => true
  end
  
  def disconnect
    request_user.offline! if request_valid?
    render :nothing => true
  end
  
  def join
    if request_valid?
      request_user.online!
      
      # This should add the request_user to a game/lobby
      
      # this should push current user name onto all channel user lists
      
      render :nothing => true
    else
      render :text => "403", :status => 403
    end
  end
  
  private
  def request_valid?
    @request_valid ||= begin
      @session = session_data_by_id(params[:session_id])
      @session && @session[:user_id].to_i == params[:client_id].to_i
    end
  end
  
  def request_user
    @user ||= User.find(@session[:user_id]) if request_valid?
  end
end