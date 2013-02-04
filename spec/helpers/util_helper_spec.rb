require 'spec_helper'
require 'util_helper'
class UtilHelperSpec
  describe "isEmptyOrNil testing" do
    it "should be true for nil input" do
      UtilHelper.isEmptyOrNil(nil).should be_true;
    end
    it "should be true for empty input" do
      UtilHelper.isEmptyOrNil("").should be_true;
    end
    it "should be false for some input" do
      UtilHelper.isEmptyOrNil("some value/object").should be_false;
    end
  end
end