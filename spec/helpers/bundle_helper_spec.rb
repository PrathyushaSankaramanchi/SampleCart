require 'spec_helper'
require 'bundle_helper'

describe BundleHelper do
    describe "Getbundlefile " do
      it "path is 'nil', so return object should nil" do
        BundleHelper.getBundleFile(nil).should be(nil);
        BundleHelper.getBundleFile(nil).should be_nil;
      end
      it "path is 'empty', so return object should nil" do
        BundleHelper.getBundleFile("").should be(nil);
      end
      it "path is wrong, should throw exception" do
        expect{BundleHelper.getBundleFile("wrong/path")}.to raise_error;
      end
      it "correct path, should return file obj" do
        path = Rails.root + "app/resourcebundles/title_en.properties";
        BundleHelper.getBundleFile(path).should be_an_instance_of(File);
        BundleHelper.getBundleFile(path).should be_a_kind_of(File);
      end
  end
  
  describe "getMessage" do
    before(:each) do
      @path = Rails.root + "app/resourcebundles/title_en.properties";
    end
    it "should return 'My first RoR cart app' for key 'base_title'" do
      BundleHelper.getMessage("base_title",BundleHelper.getProperties(@path)).should ==("My first RoR cart app");
    end
    it "should return 'show all products' for key 'cart_show_title'" do
      BundleHelper.getMessage("cart_show_title",BundleHelper.getProperties(@path)).should ==("show all products");
    end
    it "should return 'nil' for key 'emty/nil'" do
      BundleHelper.getMessage("",BundleHelper.getProperties(@path)).should be_nil;
      BundleHelper.getMessage(nil,BundleHelper.getProperties(@path)).should be_nil;
    end
    after(:each) do
      @path=nil;
    end
  end
end