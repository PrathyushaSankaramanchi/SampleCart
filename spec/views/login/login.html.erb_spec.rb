require 'spec_helper'

describe "login/login.html.erb" do
  describe "login form action" do
    it "should have login form post submit" do
      render
      rendered.should have_selector("form", :method => "post");
      rendered.should have_selector("form", :action=>"/login/submit?method=post");
    end
    
    it "should have 'email' & 'password' fields" do
      render 
      rendered.should have_selector("input", :id=>"login_email");
      rendered.should have_selector("input", :id=>"login_password");
    end
    
    it "should have 'login' submit button" do
      render
      rendered.should have_selector("input", :type=>'submit', :value=>'login');
    end
  end
end
