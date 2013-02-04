require 'spec_helper'
require_relative '../../app/models/user'

describe WelcomeController do
  render_views;

  describe "GET 'welcome'" do
    it "returns http success" do
      session[:currentUser] = nil
      get 'welcome'
      response.should be_success
      #response.should have_selector('title',:content=>'My first RoR cart app');
    end
    it "loggedin user, redirect to home" do
      session[:currentUser] = mock_model(User);
      get 'welcome'
      expect(response).to redirect_to("/home");
    end
  end

end
