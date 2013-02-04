require 'spec_helper'
require_relative '../../app/beans/login';

describe LoginController do

  describe "GET 'login'" do
    it "returns http success" do
      get 'login'
      response.should be_success
    end
  end

  describe "GET 'submit'" do
    it "No form data, should redirect to login action" do
      get 'submit'
      expect(response).to redirect_to("/login");
    end
    it "No form data, should have errors and redirect to login action" do
      get 'submit'
      expect(flash[:email]).to eq("Email is empty.");
      expect(flash[:password]).to eq("Password is empty.");
      expect(response).to redirect_to("/login");
    end
  end
  
  describe "GET 'submit'" do
    it "No form data, user not exist, should redirect to login action" do
      
      pending; # learning to set up form values to this test case
      
      login_params = {:login_email => "notexistindb@email.com", :login_password => "abcdefg"};
      @attr = {:login => login_params};      
      get 'submit'
      expect(flash[:userNotExist]).to eq("Email/password does not match.");
      expect(session[:currentUser]).to be_nil;
      expect(response).to redirect_to("/login");
    end
  end

end
