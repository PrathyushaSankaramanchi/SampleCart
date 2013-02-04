#! /usr/bin/env ruby
require 'rubygems'

require_relative '../helpers/XMLDataParser'

include XMLDataParser 
  
  class ShippingController < ApplicationController    
    DEFAULT_FILE_PATH = Rails.root + "app/service/cartconfigxmls/"
    WEBSITE_FILE_PATH = DEFAULT_FILE_PATH + "website/"    
    
    def shipping  
      if(session[:currentUser] != nil)
        shippingParser = Reader.new()
        websiteName = shippingParser.getURL(DEFAULT_FILE_PATH,WEBSITE_FILE_PATH,"snapfish_us_configurations.xml")      
        @shippingInfo = shippingParser.getXMLData()
        uri_excluding_base_url = 'cart'
        account_oid = 5000050
        partner_oid = 1
        label = 'mobile'
        tax = 'real'
        @orders = CartXmlParser.getOrders(uri_excluding_base_url, account_oid, partner_oid, label, tax)
        puts("orders is #{@orders}")
        @secure = request.headers["HTTPS"]
      else
        redirect_to :controller=>"/login", :action=>"login";
      end
    end
     
  end










