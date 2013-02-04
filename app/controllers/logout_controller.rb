class LogoutController < ApplicationController
  def logout
    # remove session value
    session[:currentUser] = nil;
    # redirect to welcome page
    redirect_to :controller => "welcome", :action => "welcome";
  end
end
