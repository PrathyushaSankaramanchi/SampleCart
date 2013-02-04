require 'httpclient'
require 'openssl'
require_relative '../helpers/bundle_helper'
module HttpClientUtil
  # TODO: Get file relative path dynamically instead using complete path
    
  public
  def HttpClientUtil.getContent(uri_excluding_base_url=nil, query_params=nil)
    @service_config_props = HttpClientUtil.getServiceConfigProperties();
    @baseUrl = @service_config_props["commerce_base_url"];
    @version = @service_config_props["version"];
    response_type = @service_config_props["content_type"];
    if(response_type == 'mock_xml' || response_type == 'mock_json')
      response = getMockData(response_type, uri_excluding_base_url);
    elsif(response_type == 'xml' || response_type == 'json')
      client = HTTPClient.new();
      # ignoring security certificate
      client.ssl_config.verify_mode = OpenSSL::SSL::VERIFY_NONE;
      begin
        # if mime type setting is wrong in config file by default JSON response will come
        response_mime_type =  @service_config_props[response_type+"_mime_type"];
        response = client.get_content(@baseUrl+"/"+@version+"/"+uri_excluding_base_url, query_params, {"Accept"=>response_mime_type})
        puts "Success response for URL: #{@baseUrl+ "/"+uri_excluding_base_url} in the format of #{response_type}";
      rescue StandardError => err
        puts err; # log this error
        response = "ERROR";
      end 
    else
      response = "Invalid response type.";
      # throw exception
      raise StandardError.new(response);
    end
  return response;
end

public
def HttpClientUtil.getServiceConfigProperties()
  return BundleHelper.getProperties(Rails.root + "app/service/service_configurations.properties");
end
public
def HttpClientUtil.getMockData(response_type, uri_excluding_base_url)
  # TODO: get file URL dynamically
  if (response_type == 'mock_xml')
    return response_mock_data = File.new(Rails.root +  "app/service/mockfiles/xml/cart/cart_xml_mock.xml").read;    
  else (response_type == 'mock_json')
    return response_mock_data = File.new(Rails.root + "app/service/mockfiles/json/cart/cart_json_mock").read;
  end
end

=begin
# client should call like below
  uri_excluding_base_url = 'order';
  query_params = {"accountId"=>"12000050", "partnerId"=>"2", "label"=>"noncart", "tax"=>"real"};
    
  puts HttpClientUtil.getContent(uri_excluding_base_url, query_params);
=end
end
