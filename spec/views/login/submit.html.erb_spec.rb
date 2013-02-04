require 'spec_helper'

describe "login/submit.html.erb" do
  it "should have content" do
    render
    rendered.should contain('Submit page');
  end
end
