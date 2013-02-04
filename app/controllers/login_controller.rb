require_relative '../beans/login';
require_relative '../helpers/util_helper';
require_relative '../models/user';

class LoginController < ApplicationController
  def login
    # just to redirect to login page
  end

  def submit
    # get form values
    login_parameters = params[:login];
    loginBean = Login.new();
    if(!UtilHelper.isEmptyOrNil(login_parameters))
      loginBean.email = login_parameters[:email];
      puts(loginBean.email);
      loginBean.password = login_parameters[:password];
    end
    #validate fields
    @errors = Hash.new();
    validateForm(loginBean);
    if(@errors.size > 0)
      flash[:email] = @errors[:email];
      flash[:password] = @errors[:password];
      # redirect to login with error messages
      redirect_to :action => :login;
      return false;
    end
    # verify with DB
    user = User.where("email='#{loginBean.email}' AND password='#{loginBean.password}'");
    userExist = user.exists?;
    if (userExist) #means user exist
      # set session variable
      #id1 = user[:email];
      session[:currentUser] = user[0];
      # redirect to home page
      redirect_to home_path;
    elsif
      # else display errors
      flash[:userNotExist] = "Email/password does not match.";
      redirect_to :action => :login;
    end
  end
  
  def validateForm(loginBean)
    if(UtilHelper.isEmptyOrNil(loginBean.email))
      @errors[:email] = "Email is empty.";
    end
    if(UtilHelper.isEmptyOrNil(loginBean.password))
      @errors[:password] = "Password is empty.";
    end
  end
end
