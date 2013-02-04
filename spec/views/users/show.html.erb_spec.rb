require 'spec_helper'

describe "users/show" do
=begin  
  before(:each) do
    @user = assign(:user, stub_model(User,
      :firstname => "Firstname",
      :lastname => "Lastname",
      :email => "Email",
      :password => "Password"
    ))
  end
=end
  it "renders attributes in <p>" do
    pending
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Firstname/)
    rendered.should match(/Lastname/)
    rendered.should match(/Email/)
    rendered.should match(/Password/)
  end
end
