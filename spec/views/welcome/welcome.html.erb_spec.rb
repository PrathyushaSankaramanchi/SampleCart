require 'spec_helper'

describe "welcome/welcome.html.erb" do
  it "should have 'h1' content"do
    render
    rendered.should have_selector("h1", :content=>"Welcome to my sample WWC");
  end
  
end
