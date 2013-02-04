require 'webmock/rspec'
require 'spec_helper';
require 'cart_xml_parser';

class CartXmlParserSpec
  describe "verify cart orders object data" do
    cart_url= "";
    uri_excluding_base_url= "";
    query_params = "";
   
    before(:each) do
     uri_excluding_base_url = 'cart';
     query_params = {"accountOid"=>"5000050", "partnerOid"=>"1", "label"=>"mobile", "tax"=>"real"};
     cart_url = "https://ecommerce1.qa.snapfish.com/v1/cart?accountOid=5000050&partnerOid=1&label=mobile&tax=real";
     stub_response_mock_data = File.new(Rails.root + "app/service/mockfiles/xml/cart/cart_xml_mock.xml").read;
     stub_request(:get, cart_url).with(:headers => {'Accept'=>'text/xml'}).to_return(:status=>200, :body=>stub_response_mock_data);
   end
   
    it "get cart orders and verify them" do
      orders = CartXmlParser.getOrders(uri_excluding_base_url,'5000050','1','mobile');
      orders.length.should eq(1);
    end
    
    it "Should have at least one shipbin with at least one lineitem" do
      orders = CartXmlParser.getOrders(uri_excluding_base_url,'5000050','1','mobile');
      orders.each do |order|
        order[1].shipBins.length >= 1
        order[1].shipBins.each do |shipbin|
          shipbin[1].lineItems.length >= 1
      end
      end
    end
    
  end
end