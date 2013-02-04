require 'webmock/rspec'
#require 'spec_helper'
require_relative '../../app/service/http_client_util'

describe HttpClientUtil do

 describe "Verify ReST API call" do
   cart_url= "";
   uri_excluding_base_url= "";
   query_params = "";
   
   before(:all) do
     uri_excluding_base_url = 'cart';
     query_params = {"accountOid"=>"3050", "partnerOid"=>"50", "label"=>"cart", "tax"=>"real"};
     cart_url = "https://ecommerce1.qa.snapfish.com/v1/cart?accountOid=3050&partnerOid=50&label=cart&tax=real";
   end
   
   it "should return successful json response" do
      # mock/stub service_configurations.properties file
      service_cofig_array = {'content_type'=>'json', 'json_mime_type'=>'application/json', 'commerce_base_url'=>'https://ecommerce1.qa.snapfish.com', 'version'=>'v1'};
      HttpClientUtil.stub(:getServiceConfigProperties).and_return(service_cofig_array);      
      
      stub_response_mock_data = File.new(Rails.root + "app/service/mockfiles/json/cart/cart_json_mock").read;
      stub_request(:get, cart_url).with(:headers => {'Accept'=>'application/json'}).to_return(:status=>200, :body=>stub_response_mock_data);
      expect(HttpClientUtil.getContent(uri_excluding_base_url, query_params)).to_not be_nil;
      expect(HttpClientUtil.getContent(uri_excluding_base_url, query_params)).to eq(stub_response_mock_data);
      # should try with more expects, like status, mime type, content
    end
    
    it "should return successful xml response" do
      # mock/stub service_configurations.properties file
      service_cofig_array = {'content_type'=>'xml', 'xml_mime_type'=>'text/xml', 'commerce_base_url'=>'https://ecommerce1.qa.snapfish.com', 'version'=>'v1'};
      HttpClientUtil.stub(:getServiceConfigProperties).and_return(service_cofig_array);      
      
      stub_response_mock_data = File.new(Rails.root + "app/service/mockfiles/xml/cart/cart_xml_mock.xml").read;
      stub_request(:get, cart_url).with(:headers => {'Accept'=>'text/xml'}).to_return(:status=>200, :body=>stub_response_mock_data);
      expect(HttpClientUtil.getContent(uri_excluding_base_url, query_params)).to_not be_nil;
      expect(HttpClientUtil.getContent(uri_excluding_base_url, query_params)).to eq(stub_response_mock_data);
      # should try with more expects, like status, mime type, content
    end
    
    it "should throw error as content_type is invalid" do
      # mock/stub service_configurations.properties file
      service_cofig_array = {'content_type'=>'INVALID', 'json_mime_type'=>'application/json', 'commerce_base_url'=>'https://ecommerce1.qa.snapfish.com', 'version'=>'v1'};
      HttpClientUtil.stub(:getServiceConfigProperties).and_return(service_cofig_array);
      
      expect{HttpClientUtil.getContent(uri_excluding_base_url, query_params)}.to raise_error('Invalid response type.');
    end
    
    it "should return successful mock json response" do
      # mock/stub service_configurations.properties file
      stub_response_mock_data = File.new(Rails.root + "app/service/mockfiles/json/cart/cart_json_mock").read;
      service_cofig_array = {'content_type'=>'mock_json', 'json_mime_type'=>'application/json', 'commerce_base_url'=>'https://ecommerce1.qa.snapfish.com', 'version'=>'v1'};
      HttpClientUtil.stub(:getServiceConfigProperties).and_return(service_cofig_array);      
      
      expect(HttpClientUtil.getContent(uri_excluding_base_url, query_params)).to_not be_nil;
      expect(HttpClientUtil.getContent(uri_excluding_base_url, query_params)).to eq(stub_response_mock_data);
      # should try with more expects, like status, mime type, content
    end
    
    it "should return successful mock xml response" do
      stub_response_mock_data = File.new(Rails.root + "app/service/mockfiles/xml/cart/cart_xml_mock.xml").read;
      # mock/stub service_configurations.properties file
      service_cofig_array = {'content_type'=>'mock_xml', 'xml_mime_type'=>'text/xml', 'commerce_base_url'=>'https://ecommerce1.qa.snapfish.com', 'version'=>'v1'};
      HttpClientUtil.stub(:getServiceConfigProperties).and_return(service_cofig_array);      
      
      expect(HttpClientUtil.getContent(uri_excluding_base_url, query_params)).to_not be_nil;
      expect(HttpClientUtil.getContent(uri_excluding_base_url, query_params)).to eq(stub_response_mock_data);
      # should try with more expects, like status, mime type, content
    end
 end
end

