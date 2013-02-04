require 'spec_helper'

describe "header/_header.html.erb" do
  
  describe "should have valid information" do  
        
        it "should have the selector called 'div'" do   
          render         
          rendered.should have_selector('div', :id => 'header')
        end  
        
        it "should have the selector called 'div'" do   
          render         
          rendered.should have_selector('div', :class => 'cart-header')
        end 
         
        it "should have the selector called 'div'" do   
          render         
          rendered.should have_selector('div', :class => 'header')
        end
        
        it "should have the selector called 'div'" do   
          render         
          rendered.should have_selector('div', :class => 'header-container')
        end      
        
        it "should have the selector called 'div'" do   
          render         
          rendered.should have_selector('div', :class => 'left')
        end
        
        it "should have the selector called 'div'" do   
          render         
          rendered.should have_selector('div', :class => 'right header-links')
        end
        
        it "should have the selector called 'div'" do   
          render         
          rendered.should have_selector('div', :class => 'clear')
        end              
        
  end
  
  describe "should be success once user is signed in" do
      describe "success" do  
        
        before(:each) do
           session[:currentUser] = mock_model(User)
        end
        
        it "should have new link called logout" do          
          render
          rendered.should have_selector 'a',:href => '/logout',:content => 'logout'
        end
        
        it "should have a new link called back to cart" do          
          render
          rendered.should have_selector 'a',:href => '/shoppingcart',:content => 'Back to cart'
        end
        
        it "should not have a new link called welcome" do          
          render
          rendered.should_not have_selector 'a',:href => '/welcome',:content => 'welcome'
        end
        
        it "should not have a new link called login" do          
          render
          rendered.should_not have_selector 'a',:href => '/login',:content => 'log in'
        end
        
        it "should not have a new link called signup" do          
          render
          rendered.should_not have_selector 'a',:href => '/signin',:content => 'signup'
        end
      end 
   
   
    describe "failure" do
        before(:each) do
          session[:currentUser] = nil
        end
        
        it "should have a new link called welcome" do          
          render
          rendered.should have_selector 'a',:href => '/welcome',:content => 'welcome'
        end
        
        it "should have a new link called login" do          
          render
          rendered.should have_selector 'a',:href => '/login',:content => 'log in'
        end
        
        it "should have a new link called signup" do          
          render
          rendered.should have_selector 'a',:href => '/signin',:content => 'signup'
        end
        
        it "should not have new link called logout" do          
          render
          rendered.should_not have_selector 'a',:href => '/logout',:content => 'logout'
        end
        
        it "should not have a new link called back to cart" do          
          render
          rendered.should_not have_selector 'a',:href => '/shoppingcart',:content => 'Back to cart'
        end
      end      
   end
   
end