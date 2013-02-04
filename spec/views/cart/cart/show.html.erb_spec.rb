require 'spec_helper'
require 'webmock/rspec'

describe "cart/cart/show.html.erb" do
  cart_uri = 'cart';
    before(:each) do
     session[:currentUser] = mock_model(User);
     cart_uri = 'cart';
     query_params = {"accountOid"=>"12000050", "partnerOid"=>"2", "label"=>"cart", "tax"=>"real"};
     cart_url = "https://ecommerce1.qa.snapfish.com/v1/" + cart_uri + "?accountOid=5000050&partnerOid=1&label=mobile&tax=real";
     stub_response_mock_data = File.new(Rails.root + "app/service/mockfiles/xml/cart/cart_xml_mock.xml").read;
     stub_request(:get, cart_url).with(:headers => {'Accept'=>'text/xml'}).to_return(:status=>200, :body=>stub_response_mock_data);
     
     @orders = Cart::CartController.new().getCartOrders();
   end
   
  it "should have orders content" do    
    render
    
    rendered.should have_selector("h1", :content => "Shopping cart")
    rendered.should have_selector("div", :id => 'order_basket');
    rendered.should contain('Total Orders');
  end
  
  it "should have 'qty'" do    
    render
    rendered.should contain('Qty');    
  end
  
  #it "should have 'sku'" do  
  #  render
  #  rendered.should contain('SKU');
  #end
  
  it "should have 'price'" do    
    render
    rendered.should contain('Price');    
  end
  
  it "should have 'shipping'" do  
    render
    rendered.should contain('Shipping');
  end
  
  it "should have 'product total'" do  
    render
    rendered.should contain('Product total');
  end
  
  #it "should have 'product shipping total'" do  
  #  render
  #  rendered.should contain('Shipping total');
  #end
  
  #it "should have 'product tax'" do  
  #  render
  #  rendered.should contain('Product tax');
  #end
  
  it "should have 'order total'" do  
    render
    rendered.should contain('Order Total');
  end
  
  #it "should have 'total tax'" do  
  #  render
  #  rendered.should contain('Total Tax');
  #end
  
#pending test cases - START

  xit "should have 'thumb nail image'" do    
    render
    rendered.should have_selector("img", :src=>'');
  end
  
  xit "should have 'edit' link" do  
    render
    rendered.should have_selector("a", :href=>'javascript:edit()');
  end
  
  xit "should have 'delete link'" do  
    render
    rendered.should have_selector("a", :href=>'javascript:delete()');
  end
  
  xit "should have 'total shipping'" do  
    #render
  end
  
  xit "should have 'check out' button" do  
    render
    rendered.should have_selector("a", :href=>'javascript:checkout()');
  end
  
  xit "should have 'cancel button'" do  
    render
    rendered.should have_selector("a", :href=>'javascript:cancel()');
  end

#pending test cases - END
  
  it "should not have orders content" do
    cartController = Cart::CartController.new();
    @orders = nil;
    render
    rendered.should have_selector("h1", :content => "Shopping cart")
    rendered.should_not have_selector("div", :id => 'order_basket');
  end
end
