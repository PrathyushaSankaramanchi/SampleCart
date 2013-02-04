require_relative "../helpers/util_helper";
class HomeController < ApplicationController
  def home
    @currentUser = session[:currentUser];
    if(UtilHelper.isEmptyOrNil(@currentUser))
      redirect_to :controller => 'welcome', :action => 'welcome';
    end
  end
end
