require_relative '../../helpers/title_bundle_helper'
require_relative '../../helpers/cart_xml_parser'
class Cart::CartController < ApplicationController
  # Show all the order baskets
  def show
    if(session[:currentUser] != nil)
      # Get title from bundle file 
      @title = TitleBundleHelper.getMessage("cart_show_title"); #String
      @orders = getCartOrders();
      @secure = request.headers["HTTPS"];
      
    elsif
      redirect_to :controller=>"/login", :action=>"login";
    end
  end
  def getCartOrders()
    uri_excluding_base_url = 'cart'
    account_oid = 5000050;
    partner_oid = 1;
    label = 'mobile';
    tax = 'real';
    return CartXmlParser.getOrders(uri_excluding_base_url, account_oid, partner_oid, label, tax); # Hash key=orderID, val=shoppingcartbean obj
  end
end
