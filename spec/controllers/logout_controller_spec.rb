require 'spec_helper'
require_relative '../../app/models/user';

describe LogoutController do

  describe "GET 'logout'" do
    it "should redirect to welcome page" do
      get 'logout'
      expect(response).to redirect_to("/welcome");
    end
    it "should redirect to welcome page, even session has login user data" do
      session[:currentUser] = mock_model(User);
      get 'logout'
      expect(response).to redirect_to("/welcome");
    end
  end

end
