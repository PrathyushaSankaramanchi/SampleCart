require 'spec_helper'

include XMLDataParser 

describe "shipping/shipping.html.erb" do
  
  describe "should have a valid form that contains" do  
      before(:each) do
        session[:currentUser] = mock_model(User)
        doc = Reader.new()        
        doc.getURL(Rails.root + "app/service/cartconfigxmls/","/drive2/AptanaWorkspace/ShoppingCart/app/service/cartconfigxmls/website/","snapfish_us_configurations.xml")
        @shippingInfo = doc.getXMLData()        
      end
    
        it "should have the selector called 'h3'" do   
          render         
          rendered.should have_selector('h3')
        end 
        
        it "should have the selector called 'b'" do   
          render         
          rendered.should have_selector('b')
        end   
        
        it "should have the h3 'Shipping'" do   
          render         
          rendered.should contain('Shipping')
        end 
        
        it "should contain text ship to my address" do
          render
          rendered.should contain('Ship to my address')
        end
        
        it "should contain text Ship to a different address" do
          render
          rendered.should contain('Ship to a different address')
        end
        
        it "should contain function showAddress()" do
          render
          rendered.should contain('function showAddress()')
        end
        
        it "should contain a form with action shipping with method post" do
          render
          rendered.should have_selector("form", :action => "/shipping?method=post", :method => "post")
        end        
        
        it "should contain div with class forms" do
          render
          rendered.should have_selector('div', :class => 'forms')
        end
                
        #it "should contain div with id shipping_same_address" do
        #  render
        #  rendered.should have_selector('div', :id => 'shipping_same_address')
        #end
        
        #it "should contain radio button address_my" do
        #  render
        #  rendered.should have_selector('input [checked="checked"] [id="address_my"] [name="address"] [onclick="javascript:showAddress()"] [type="radio"] [value="my"]')          
        #end
        
        #it "should have a label for my_addresslbl" do
        #  render
        #  rendered.should have_selector('label [for="my_addresslbl"]')        
        #end
        
        #it "should contain div with id shipping_different_address" do
        #  render
        #  rendered.should have_selector('div', :id => 'shipping_different_address')
        #end
        
        #it "should contain radio button address_different" do
        #  render
        #  rendered.should have_selector('input [id="address_different"] [name="address"] [onclick="javascript:showAddress()"] [type="radio"] [value="different"]')
        #end
        
        #it "should have a label for different_addresslbl" do
        #  render
        #  rendered.should have_selector('label [for="different_addresslbl"]')
        #end
        
        it "should contain div with id as shipping_container" do
          render
          rendered.should have_selector('div', :id => 'shipping_container')
        end
        
        #it "should contain div with class as buttons and style as width equal to 35%" do
        #  render
        #  rendered.should have_selector('div', :class => 'buttons', :style => 'width:35%')
        #end
        
        it "should contain a script with type text/template and id shipping-address" do
          render
          rendered.should have_selector('script [type="text/template"] [id="shipping-address"]')
        end
        
        it "should have dropdown for shipping codes" do
          render
          rendered.should have_selector('select [id="shippingcodename_shippingcodeid"] [name="shippingcodename[shippingcodeid]"]')          
        end
        
        it "should have script tag which accepts a text or javascript" do
          render
          rendered.should have_selector('script [type="text/javascript"]')
        end
        
        it "should contain text Subtotal" do   
          render
          rendered.should contain('Subtotal')
        end
        
        it "should contain text Standard S&H" do   
          render
          rendered.should contain('Standard S&H')
        end
        
        it "should contain text Order Total" do   
          render
          rendered.should contain('Order Total')
        end
        
        #it "should have selector 'a' with shoppingcart" do
        #  render
        #  rendered.should have_selector("a", :href => 'shoppingcart', :class => 'button-02-s')
        #end
        
        #it "should have selector 'a' with " do
        #  render
        #  rendered.should have_selector("a", :href => '', :class => 'button-01-s pushleft-2')
        #end
  end
  
end