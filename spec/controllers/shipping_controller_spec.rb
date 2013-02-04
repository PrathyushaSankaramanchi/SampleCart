require 'spec_helper'
require_relative '../../app/helpers/XMLDataParser'
include XMLDataParser 

describe ShippingController do
  render_views
  
  describe "get shipping" do
    it "returns http success" do
      get 'shipping'
      response.should be_success      
    end  
    
    it "redirect to login" do
      session[:currentUser] = nil   
      get 'shipping'   
      expect(response).to redirect_to("/login")
    end
  end
  
  before(:each) do
      session[:currentUser] = mock_model(User)
  end
     
  describe "File should be nil if nothing is passed to it" do
     
      it "path is not 'nil', should not receive nil" do
         doc = Reader.new()
         expect{doc.getURL(Rails.root + "app/service/cartconfigxmls/","/drive2/AptanaWorkspace/ShoppingCart/app/service/cartconfigxmls/website/","snapfish_us_configurations.xml")}.to_not be_nil
     end
   end
   
   describe "data should be parsed on calling getXMLData method" do
     doc = nil
     before(:all) do
       doc = Reader.new()
       doc.getURL(Rails.root + "app/service/cartconfigxmls/","/drive2/AptanaWorkspace/ShoppingCart/app/service/cartconfigxmls/website/","snapfish_us_configurations.xml")
     end
      
      it "data should not be nil" do
         expect{doc.getXMLData}.to_not be_nil
     end   
     
     after(:all) do
        doc = nil
      end
   end
   
   describe "data should be nil on giving a wrong xml path" do
     doc = nil
     before(:all) do
       doc = Reader.new()
       doc.getURL("wrong/path","wrong/file","wrong/extension")
     end
      
      it "path is wrong, should be nil" do
        doc.getXMLData.should be_nil
      end
      
      after(:all) do
        doc = nil
      end      
   end
   
   describe "Raise an error on wrong number of arguments passed" do
     doc = nil
     before(:all) do
       doc = Reader.new()       
     end
      
      it "single argument, should be error" do
        expect{doc.getURL("wrong/path/")}.to raise_error
      end
      
      it "two arguments, should be error" do
        expect{doc.getURL("wrong/path/","wrong/path/")}.to raise_error
      end
      
      after(:all) do
        doc = nil
      end
   end
   
   describe "get orders from shopping cart" do
     @orders = nil
     before(:all) do
        uri_excluding_base_url = 'cart'
        account_oid = 5000050
        partner_oid = 1
        label = 'mobile'
        tax = 'real'
        @orders = CartXmlParser.getOrders(uri_excluding_base_url, account_oid, partner_oid, label, tax)
     end
     it "expect orders not to be nil" do
       expect{@orders}.to_not be_nil
       
     end
   end

end