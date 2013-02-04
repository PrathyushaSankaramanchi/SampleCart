require 'spec_helper'
require_relative "../../app/models/user"

describe HomeController do

  describe "GET 'home'" do
    it "returns http success" do
      session[:currentUser] = mock_model(User); # mock user object and set it
      get 'home'
      response.should be_success
    end
    it "redirect to welcome" do
      session[:currentUser] = nil;
      get 'home'
      expect(response).to redirect_to("/welcome");
    end
  end

end
