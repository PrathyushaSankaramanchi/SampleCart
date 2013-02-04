require 'spec_helper'

describe "logout/logout.html.erb" do
  it "should have 'h1' content"do
    render
    rendered.should have_selector("h1", :content=>"Logout#logout");
  end
end
