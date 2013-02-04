require 'webmock/rspec'
require 'spec_helper'
#require 'cart/cart_controller'

describe Cart::CartController do
  render_views;

  describe "GET 'show'" do
    cart_uri = 'cart';
    before(:each) do
     session[:currentUser] = mock_model(User);
     cart_uri = 'cart';
     query_params = {"accountOid"=>"5000050", "partnerOid"=>"1", "label"=>"mobile", "tax"=>"real"};
     cart_url = "https://ecommerce1.qa.snapfish.com/v1/" + cart_uri + "?accountOid=5000050&partnerOid=1&label=mobile&tax=real";
     stub_response_mock_data = File.new(Rails.root + "app/service/mockfiles/xml/cart/cart_xml_mock.xml").read;
     stub_request(:get, cart_url).with(:headers => {'Accept'=>'text/xml'}).to_return(:status=>200, :body=>stub_response_mock_data);
   end
   
    it "returns http success" do
      get 'show'
      response.should be_success      
    end
    
    it "should have 'BRW' status orders only" do
      get 'show'
      cartController = Cart::CartController.new();
      orders = cartController.getCartOrders();
      expect(orders.length).to eq 1;
      orders.each { |order|
        order[1].status.should_not nil;
        order[1].status.should eq('BRW');
      }
    end
    
    #it "should have correct title" do
    #  get 'show'
    #  response.should be_success
    #  response.should have_selector("title", :content => "My first RoR cart app | show all products");
    #end
    
    it "redirect to login" do
      session[:currentUser] = nil;
      get 'show'
      expect(response).to redirect_to("/login");
    end

  end

end
