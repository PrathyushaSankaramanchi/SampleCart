require 'spec_helper'

describe "home/home.html.erb" do
  it "should have content 'welcome to'" do
    session[:currentUser] = {:firstname=>'Prathyusha', :lastname=>'Sankaramanchi'};
    
    render
    rendered.should contain('welcome to Prathyusha Sankaramanchi');
  end
end
