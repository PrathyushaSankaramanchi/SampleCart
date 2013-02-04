require_relative '../helpers/util_helper'
class WelcomeController < ApplicationController
  def welcome
    # if user already logged in then redirect to home page
    # else goto welcome page
    if(!UtilHelper.isEmptyOrNil(session[:currentUser]))
      redirect_to :controller=>"home", :action=>"home";
    end    
  end
  
end
