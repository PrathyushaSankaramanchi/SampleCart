require 'spec_helper'

describe Cart::CartController do
  
    it "should route to cart/cart#show" do
      get('/shoppingcart').should route_to('cart/cart#show');
    end
end